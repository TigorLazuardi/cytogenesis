import 'package:flutter/foundation.dart';

class Note {
  int pageIndex;
  int type;
  int id;
  int tick;
  int x;
  int holdTick;
  int nextID;
  int linkID;
  bool markedForDelete;

  Note({
    @required this.pageIndex,
    @required this.type,
    @required this.tick,
    @required this.x,
    this.holdTick = 0,
    this.nextID = 0,
    this.linkID = -1,
  }) : markedForDelete = false;

  Note.fromJSON(Map<String, dynamic> note)
      : pageIndex = note['page_index'],
        type = note['type'],
        id = note['id'],
        tick = note['tick'],
        x = note['x'],
        holdTick = note['hold_tick'],
        nextID = note['next_id'],
        linkID = note['link_id'],
        markedForDelete = false;

  Map<String, dynamic> toJSON() => {
        'page_index': pageIndex,
        'type': type,
        'id': id,
        'tick': tick,
        'x': x,
        'hold_tick': holdTick,
        'next_id': nextID,
        'link_id': linkID,
      };
}

class NoteList {
  List<Note> _notes;
  Map<int, List<int>> _chains;
  Map<int, int> _reIndexLinkID;

  NoteList() {
    _notes = <Note>[];
    _chains = {};
  }

  NoteList.fromJSON(Map<String, dynamic> root) {
    var noteList = root['note_list'];
    var count = noteList.length;
    _chains = {};
    for (var i = 0; i < count; i++) {
      var note = Note.fromJSON(noteList[i]);
      // Register new chain
      if (note.type == 3) {
        // Bad note. Clean on next marshal
        if (note.nextID == -1) {
          note.markedForDelete = true;
        } else {
          _chains[note.id] = [note.nextID];
        }
      }
      // Add chain children to existing chains
      if (note.type == 4) {
        for (final parent in _chains.keys) {
          if (_chains[parent].contains(note.id)) {
            if (note.nextID != -1) {
              _chains[parent].add(note.nextID);
            }
            break;
          }
        }
      }
      _notes.add(note);
    }
  }

  List<Map<String, dynamic>> toJSON() {
    List<Map<String, dynamic>> marshalledNotes;
    marshal();
    for (var i = 0; i < _notes.length; i++) {
      marshalledNotes.add(_notes[i].toJSON());
    }
    return marshalledNotes;
  }

  /// marshal sorts the notes by timestamp, deletes marked for deletion notes and re-indexes them.
  /// This function does heavy work and should be called sparingly.
  marshal() {
    Map<int, List<int>> newChains = {};
    _notes.sort((a, b) => a.tick.compareTo(b.tick));
    _notes.removeWhere((x) => x.markedForDelete);

    for (var i = 0; i < _notes.length; i++) {
      var oldNote = _notes[i];

      _notes[i].id = i; // Re-index

      // Re-register Link ID
      if (oldNote.linkID != -1) {
        var res = _isRegisteredOnReIndexLinkID(oldNote.id);
        if (res.ok) {
          oldNote.linkID = res.value;
        } else {
          var origin = i;
          var target = oldNote.linkID;
          _reIndexLinkID[origin] = target;
        }
      }

      // Re-Register chain parent IDs
      if (oldNote.type == 3) {
        // Move old parent IDs
        for (final parentID in _chains.keys) {
          if (parentID == oldNote.id) {
            newChains[i] = _chains[parentID];
            break;
          }
        }
      }

      // Move nextID of chains
      // Triple loop happens here, but this uses nice syntax.
      // May need Optimization if app is slow.
      if (oldNote.type == 4) {
        for (final parentID in newChains.keys) {
          if (newChains[parentID].contains(oldNote.id)) {
            var index = newChains[parentID].indexOf(oldNote.id);
            newChains[parentID][index] = i;
            break;
          }
        }
      }
    }

    _chains = newChains;
    _applyNewChainToNoteList();
  }

  /// Returns true if map key exist and the origin of it.
  _Result<bool, int> _isRegisteredOnReIndexLinkID(int noteID) {
    for (final k in _reIndexLinkID.keys) {
      if (_reIndexLinkID[k] == noteID) return _Result(true, k);
    }
    return _Result(false, -1);
  }

  _applyNewChainToNoteList() {
    for (final parentChainID in _chains.keys) {
      _notes[parentChainID].nextID = _chains[parentChainID][0];
      for (var i = 0; i < _chains[parentChainID].length; i++) {
        var childChainID = _chains[parentChainID][i];
        if (_chains[parentChainID][i] == _chains[parentChainID].last) {
          _notes[childChainID].nextID = -1;
        } else {
          _notes[childChainID].nextID = _chains[parentChainID][i + 1];
        }
      }
    }
  }
}

class _Result<T, U> {
  T ok;
  U value;
  _Result(this.ok, this.value);
}
