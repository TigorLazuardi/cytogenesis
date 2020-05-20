import 'dart:io';

import 'package:CytoGenesis/models/chart.dart';
import 'package:CytoGenesis/models/meta.dart';

class Project {
  File musicFile;
  File imageFile;
  Map<String, Chart> charts;
  Meta meta;

  Project(this.musicFile, this.imageFile, this.meta);
}
