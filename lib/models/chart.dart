import 'package:flutter/foundation.dart';
import 'package:CytoGenesis/glossary.dart';

class Chart {
  String type;
  String name;
  int difficulty;
  String path;

  Chart.easy({
    @required this.difficulty,
    this.name,
  })  : type = 'easy',
        path = 'chart.easy.json';

  Chart.hard({
    @required this.difficulty,
    this.name,
  })  : type = 'hard',
        path = 'chart.hard.json';

  Chart.ex({
    @required this.difficulty,
    this.name,
  })  : type = 'extreme',
        path = 'chart.ex.json';

  Chart.fromJSON(Map<String, dynamic> j)
      : type = j[CHART_TYPE],
        name = j[CHART_NAME],
        difficulty = j[CHART_DIFFICULTY],
        path = j[CHART_PATH];

  Map<String, dynamic> toJSON() => {
        CHART_TYPE: type,
        CHART_NAME: name,
        CHART_DIFFICULTY: difficulty,
        CHART_PATH: path,
      };
}
