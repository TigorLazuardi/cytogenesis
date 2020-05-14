import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(Root());

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'CytoGenesis',
      home: Scaffold(
        appBar: EmptyAppBar(),
        body: _BodyColumn(),
      ),
    );
  }
}

// Handle status bar bullshit. Source: https://github.com/flutter/flutter/issues/4518#issuecomment-480115134
class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const double _defaultElevation = 4.0;
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final AppBarTheme appBarTheme = AppBarTheme.of(context);
    final Brightness brightness =
        appBarTheme.brightness ?? themeData.primaryColorBrightness;
    final SystemUiOverlayStyle overlayStyle = brightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;

    return Semantics(
      container: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle,
        child: Material(
          color: appBarTheme.color ?? themeData.primaryColor,
          elevation: appBarTheme.elevation ?? _defaultElevation,
          child: Semantics(
            explicitChildNodes: true,
            child: Container(),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
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
