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
}
