import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../globals.dart';

class RecentFile {
  String projectID;
  String projectName;
  String zipPath;
  bool cached;
  String musicPath;
  String previewPath;
  String imagePath;
  String metaPath;
  String lastOpen;

  RecentFile({
    @required this.projectID,
    @required this.projectName,
    @required this.zipPath,
    @required this.cached,
    this.musicPath,
    this.previewPath,
    this.imagePath,
    this.metaPath,
  })  : assert(projectID != null),
        assert(projectName != null),
        assert(cached != null);

  RecentFile.fromJSON(Map<String, dynamic> j) {
    projectID = j['project_id'];
    projectName = j['project_name'];
    zipPath = j['zip_path'];
    cached = j['cached'];
    musicPath = j['music_path'];
    previewPath = j['preview_path'];
    imagePath = j['image_path'];
    metaPath = j['meta_path'];
  }

  Map<String, dynamic> toJson() => {
        'project_id': projectID,
        'project_name': projectName,
        'zip_path': zipPath,
        'cached': cached,
        'music_path': musicPath,
        'preview_path': previewPath,
        'image_path': imagePath,
        'meta_path': metaPath,
      };
}

class RecentFileList {
  List<RecentFile> recentFiles;
  File _file;

  RecentFileList();

  Future<Result<bool, String>> load() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = dir.path;
    _file = File('$path/recent_files.json');

    try {
      _unmarshal(await _file.readAsString());
      return Result(true, "Load file success.");
    } catch (e) {
      // TODO: Clear this print
      print(e);
      return Result(false, "File not found");
    }
  }

  /// Returns Cached on var1 and Uncached on var2
  Result<List<RecentFile>, List<RecentFile>> getByCache() {
    _verifyCache();
    var cached = recentFiles.where((rf) => rf.cached);
    var uncached = recentFiles.where((rf) => !rf.cached);
    return Result(cached, uncached);
  }

  _unmarshal(String jsonString) {
    final j = jsonDecode(jsonString);
    for (var i = 0; i < j.length; i++) {
      recentFiles.add(RecentFile.fromJSON(j[i]));
    }
  }

  _verifyCache() {
    recentFiles.forEach((RecentFile rf) {
      if (rf.cached) {
        var mus = File(rf.musicPath);
        var pre = File(rf.previewPath);
        var meta = File(rf.metaPath);
        if (!mus.existsSync() || !pre.existsSync() || !meta.existsSync()) {
          rf.cached = false;
        }
      }
    });
  }

  Future<Result<bool, String>> save() async {
    List<Map<String, dynamic>> marshalledRecentList;
    recentFiles.forEach((re) => marshalledRecentList.add(re.toJson()));
    var content = jsonEncode(marshalledRecentList);
    try {
      await _file.writeAsString(content, encoding: Encoding.getByName('utf-8'));
      return Result(true, "File saved");
    } catch (e) {
      print(e);
      return Result(false, "Failed to save file");
    }
  }
}
