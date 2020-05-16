import 'package:flutter/material.dart';
import 'screens/projects.dart';

void main() => runApp(Root());

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CytoGenesis',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => ProjectScreen(),
      },
    );
  }
}

