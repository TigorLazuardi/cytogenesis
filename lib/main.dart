import 'package:flutter/material.dart';
import 'screens/projects.dart';
import 'package:CytoGenesis/screens/create_new.dart';

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
      },
    );
  }
}

