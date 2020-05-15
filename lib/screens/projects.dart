import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProjectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      // appBar: EmptyAppBar(),
      appBar: AppBar(
        title: Text('CytoGenesis'),
      ),
      body: _BodyColumn(),
    );
  }
}

class _BodyColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          child: _TopRow(),
          // margin: EdgeInsets.only(bottom: 5),
        ),
        Expanded(
          child: _ProjectRecent(),
        ),
      ],
    );
  }
}

class _TopRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 50,
            child: FlatButton(
              child: Text(
                'Create New',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => print('Create New Pressed'),
              color: Colors.blue,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              height: 50,
              width: 4,
              color: Colors.blue,
            ),
            Container(
              height: 50,
              width: 2,
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.all(Radius.elliptical(75, 1000)),
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            height: 50,
            child: FlatButton(
              child: Text(
                'Open',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => print('Open Pressed'),
              color: Colors.blue,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProjectRecent extends StatefulWidget {
  @override
  _ProjectRecentState createState() => _ProjectRecentState();
}

class _ProjectRecentState extends State<_ProjectRecent> {
  int _count = 0;

  void _increaseCount() {
    setState(() {
      _count++;
    });
  }

  void _decreaseCount() {
    setState(() {
      _count--;
    });
  }

  void _setCountZero() {
    setState(() {
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          height: 50,
          color: Colors.amber[900],
          child: Center(child: Text('Count: $_count')),
        ),
        Container(
          height: 50,
          color: Colors.amber[600],
          child: FlatButton(
            child: Center(child: Text('Increase Count')),
            onPressed: _increaseCount,
          ),
        ),
        Container(
          height: 50,
          color: Colors.amber[500],
          child: FlatButton(
            child: Center(child: Text('Decrease Count')),
            onPressed: _decreaseCount,
          ),
        ),
        Container(
          height: 50,
          color: Colors.amber[100],
          child: FlatButton(
            child: Center(child: Text('Set to 0')),
            onPressed: _setCountZero,
          ),
        ),
      ],
    );
  }
}
