import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:universal_html/html.dart' as html;
import 'package:url_launcher/url_launcher.dart';

class ProjectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      appBar: AppBar(
        title: Text('CytoGenesis'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(
                CommunityMaterialIcons.github_circle,
                size: 36,
              ),
              onPressed: () async {
                String url = 'https://github.com/TigorLazuardi/cytogenesis';
                if (kIsWeb) {
                  html.window.open(url, '_blank');
                } else {
                  if (await canLaunch(url)) {
                    launch(url);
                  }
                }
              },
            ),
          ),
        ],
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
            // TODO: Glow Effect
            Container(
              height: 50,
              width: 2,
              color: Colors.lightBlue,
            ),
            Container(
              height: 50,
              width: 1,
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

class _EmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Center(child: _EmptyListImage()),
          Center(child: Text('Empty List')),
        ],
      ),
    );
  }
}

class _EmptyListImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage('assets/empty_list.jpg'));
  }
}
