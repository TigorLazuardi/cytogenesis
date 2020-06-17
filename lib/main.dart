import 'package:flutter/material.dart';
import 'package:CytoGenesis/screens/projects.dart';
import 'package:CytoGenesis/screens/create_new.dart';
import 'package:CytoGenesis/screens/music_edit.dart';
import 'package:CytoGenesis/screens/workbench.dart';

void main() => runApp(Root());

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CytoGenesis',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => ProjectScreen(),
        '/create_new': (BuildContext context) => CreateNewProjectScreen(),
        '/edit_music': (BuildContext context) => MusicEditScreen(),
        '/workbench': (BuildContext context) => WorkbenchScreen(),
      },
    );
  }
}

