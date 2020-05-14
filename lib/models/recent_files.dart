import 'dart:convert';
import 'package:flutter/foundation.dart';

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

  RecentFile.fromJSON(String jsonString) {
    final j = jsonDecode(jsonString);
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
