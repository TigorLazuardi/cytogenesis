import 'package:CytoGenesis/models/recent_files.dart';
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
  List<RecentFile> _recentFiles;
  RecentFileList _rfl;
  bool isLoading;

  @override
  void initState() {
    super.initState();
    setState(() => isLoading = true);
    _rfl = RecentFileList();
    _rfl.load().then((res) {
      if (res.var1) {
        setState(() {
          _recentFiles = _rfl.recentFiles;
        });
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading)
      return Center(
        child: CircularProgressIndicator(
          semanticsLabel: "Loading recent projects",
        ),
      );
    if (_recentFiles == null || _recentFiles.length == 0) return _EmptyList();

    List<Widget> children;
    var list = _rfl.getByCache();
    if (list.var1.length != 0) {
      children.add(
        Text('Cached Projects:'),
      );
      list.var1.forEach((rf) => children.add(Text(rf.projectName)));
      children.add(
        Text('Uncached Projects:'),
      );
    }
    list.var2.forEach((rf) => children.add(Text(rf.projectName)));
    return ListView(
      children: children,
    );
  }
}

class _EmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: _EmptyListImage(),
            ),
          ),
          Expanded(
            child: Center(child: Text('Empty List')),
          ),
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
