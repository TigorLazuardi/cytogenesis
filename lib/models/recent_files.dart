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
  RecentFileList();
  Future<Result<bool, String>> load() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('$dir/recent_files.json');

    try {
      _marshal(await file.readAsString());
      return Result(true, "Load file success.");
    } catch (e) {
      // TODO: Clear this print
      print(e);
      return Result(false, "File not found");
    }
  }

  _marshal(String jsonString) {
    final j = jsonDecode(jsonString);
    for (var i = 0; i < j.length; i++) {
      recentFiles.add(RecentFile.fromJSON(j[i]));
    }
  }

  String toJSON() {
    List<Map<String, dynamic>> marshalledRecentList;
    recentFiles.forEach((re) => marshalledRecentList.add(re.toJson()));
    return jsonEncode(marshalledRecentList);
  }
}
