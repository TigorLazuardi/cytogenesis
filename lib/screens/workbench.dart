import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:CytoGenesis/globals.dart';

class WorkbenchScreen extends StatefulWidget {
  @override
  _WorkbbenchScreenState createState() => _WorkbbenchScreenState();
}

class _WorkbbenchScreenState extends State<WorkbenchScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.restoreSystemUIOverlays();
  }

  @override
  Widget build(BuildContext context) {
    // Still need to return scaffold because base app is Material...
    return Scaffold(
      appBar: Null(),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            "Workbench",
          ),
        ),
      ),
    );
  }
}
