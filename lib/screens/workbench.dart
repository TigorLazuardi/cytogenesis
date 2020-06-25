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
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
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
      body: BaseWorkbenchLayout(),
    );
  }
}

class BaseWorkbenchLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[LeftArea(), RightArea()],
    );
  }
}

class LeftArea extends StatelessWidget {
  const LeftArea({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15),
      child: Column(
        children: <Widget>[
          TopLeftArea(),
          LeftAreaSecondRow(),
          LeftAreaThirdRow(),
          LeftAreaFourthRow(),
          Expanded(
            flex: 1,
            child: Container(),
          )
        ],
      ),
    );
  }
}

class LeftAreaFourthRow extends StatelessWidget {
  const LeftAreaFourthRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 5, right: 5),
            height: 50,
            width: 50,
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Center(
              child: Text('Hold'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5, right: 5),
            height: 50,
            width: 50,
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Center(
              child: Text('L-Hold'),
            ),
          ),
        ],
      ),
    );
  }
}

class LeftAreaThirdRow extends StatelessWidget {
  const LeftAreaThirdRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GenerateTapNoteButton(),
            GenerateFlickNoteButton(),
            GenerateChainNoteButton(),
          ],
        ),
      ),
    );
  }
}

class GenerateChainNoteButton extends StatelessWidget {
  const GenerateChainNoteButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      margin: EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Center(
        child: Text('Chain'),
      ),
    );
  }
}

class GenerateFlickNoteButton extends StatelessWidget {
  const GenerateFlickNoteButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      height: 50,
      width: 50,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Center(
        child: Text('Flick'),
      ),
    );
  }
}

class GenerateTapNoteButton extends StatelessWidget {
  const GenerateTapNoteButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      height: 50,
      width: 50,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Center(
        child: Text('Tap'),
      ),
    );
  }
}

class LeftAreaSecondRow extends StatelessWidget {
  const LeftAreaSecondRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          children: <Widget>[LeftArrowButton(), PageMeta(), RightArrowButton()],
        ),
      ),
    );
  }
}

class TopLeftArea extends StatelessWidget {
  const TopLeftArea({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[BurgerMenuButton(), SectionButton()],
        ),
      ),
    );
  }
}

class SectionButton extends StatelessWidget {
  const SectionButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      width: 110,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black,
        ),
      ),
      child: Center(
        child: Text(
          'Section',
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }
}

class RightArrowButton extends StatelessWidget {
  const RightArrowButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Arrow'),
      ),
      padding: EdgeInsets.only(right: 5, left: 5),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.red,
        ),
      ),
    );
  }
}

class PageMeta extends StatelessWidget {
  const PageMeta({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Page Meta'),
      ),
      margin: EdgeInsets.only(right: 5, left: 5),
    );
  }
}

class BurgerMenuButton extends StatelessWidget {
  const BurgerMenuButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black,
        ),
      ),
      child: Center(
        child: Text('Menu'),
      ),
      width: 50,
    );
  }
}

class LeftArrowButton extends StatelessWidget {
  const LeftArrowButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Arrow'),
      ),
      padding: EdgeInsets.only(right: 5, left: 5),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.red,
        ),
      ),
    );
  }
}

class RightArea extends StatelessWidget {
  const RightArea({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(15),
        child: Center(
          child: Text('Right'),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
