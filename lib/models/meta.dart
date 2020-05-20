import 'package:flutter/foundation.dart';
import 'package:CytoGenesis/glossary.dart';

class Meta {
  String charter;
  String musicTitle;
  String musicTitleLocal;
  String musicArtist;
  String musicArtistLocal;
  String illustrator;
  String illustrationSource;
  String projectID;

  Meta({
    @required this.charter,
    @required this.musicTitle,
    this.musicTitleLocal,
    @required this.musicArtist,
    this.musicArtistLocal,
    @required this.illustrator,
    @required this.illustrationSource,
    @required this.projectID,
  })  : assert(charter != null),
        assert(musicTitle != null),
        assert(musicArtist != null),
        assert(illustrator != null),
        assert(illustrationSource != null),
        assert(projectID != null);

  Meta.fromJSON(Map<String, dynamic> j)
      : charter = j[LEVEL_CHARTER],
        musicTitle = j[LEVEL_MUSIC_TITLE],
        musicTitleLocal = j[LEVEL_MUSIC_TITLE_LOCAL],
        musicArtist = j[LEVEL_ARTIST],
        musicArtistLocal = j[LEVEL_ARTIST_LOCAL],
        illustrator = j[LEVEL_ILLUSTRATOR],
        illustrationSource = j[LEVEL_ILLUSTRATOR_SOURCE],
        projectID = j[LEVEL_PROJECT_ID];

  Map<String, dynamic> toJSON() => {
        LEVEL_CHARTER: charter,
        LEVEL_MUSIC_TITLE: musicTitle,
        LEVEL_MUSIC_TITLE_LOCAL: musicTitleLocal,
        LEVEL_ARTIST: musicArtist,
        LEVEL_ARTIST_LOCAL: musicArtistLocal,
        LEVEL_ILLUSTRATOR: illustrator,
        LEVEL_ILLUSTRATOR_SOURCE: illustrationSource,
        LEVEL_PROJECT_ID: projectID,
      };
}

class MusicMeta {
  String path;
  _MusicBuild buildSteps;
}

class _MusicBuild {
  List<_Splice> splice;
  double addSilence;
  double tailDelete;

  Map<String, dynamic> toJSON() {
    var s = <dynamic>[];
    splice.forEach((spl) => s.add(spl.toJSON()));
    return {
      'splice': s,
      'add_silence': addSilence ?? 0.0,
      'tail_deletion': tailDelete ?? 0.0,
    };
  }

  _MusicBuild.fromJSON(Map<String, dynamic> j) {
    List<Map<String, dynamic>> s = j['splice'];
    s.forEach((x) => splice.add(_Splice.fromJSON(x)));
    addSilence = j['add_silence'] ?? 0.0;
    tailDelete = j['tail_deletion'] ?? 0.0;
  }
}

class _Splice {
  double start;
  double end;
  _Splice(this.start, this.end);
  _Splice.fromJSON(Map<String, dynamic> j)
      : start = j['start'],
        end = j['end'];
  Map<String, dynamic> toJSON() => {
        'start': start,
        'end': end,
      };
}

class BackgroundImageMeta {}
