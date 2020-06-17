import 'package:flutter/material.dart';

class MusicEditScreen extends StatefulWidget {
  @override
  _MusicEditScreenState createState() => _MusicEditScreenState();
}

class _MusicEditScreenState extends State<MusicEditScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Music"),
          actions: <Widget>[
            Builder(
              builder: (context) => FlatButton(
                child: Text('NEXT'),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/workbench',
                  );
                },
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
