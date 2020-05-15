import 'package:flutter/material.dart';
import 'globals.dart';

void main() => runApp(Root());

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    // ]);
    return MaterialApp(
      title: 'CytoGenesis',
      // home: Scaffold(
      //   appBar: EmptyAppBar(),
      //   body: _BodyColumn(),
      // ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => Scaffold(
              appBar: EmptyAppBar(),
              body: _BodyColumn(),
            ),
      },
    );
  }
}

class _TopRow extends StatelessWidget {
  Expanded _buildTopRowChild(String text) => Expanded(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 4,
              color: Colors.black87,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.black87),
              textDirection: TextDirection.ltr,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildTopRowChild('Create New'),
        _buildTopRowChild('Open'),
      ],
    );
  }
}

class _BodyColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _TopRow(),
        ),
        Expanded(
          flex: 10,
          child: _ProjectRecent(),
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
      padding: EdgeInsets.all(8),
      children: <Widget>[
        Container(
          height: 50,
          color: Colors.amber[1000],
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
