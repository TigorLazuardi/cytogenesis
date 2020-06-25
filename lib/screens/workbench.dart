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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[TopArea(), BottomArea()],
    );
  }
}

class TopArea extends StatelessWidget {
  const TopArea({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TopAreaContent(),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black,
        ),
      ),
    );
  }
}

class TopAreaContent extends StatelessWidget {
  const TopAreaContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        BurgerMenuButton(),
        LeftArrowButton(),
        PageMeta(),
        RightArrowButton()
      ],
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
        child: Text('Right Arrow'),
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
      child: Center(
        child: Text('Burger Menu'),
      ),
      margin: EdgeInsets.only(right: 5, left: 5),
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
        child: Text('Left Arrow'),
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

class BottomArea extends StatelessWidget {
  const BottomArea({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Center(
          child: Text('Bottom'),
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
