import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

const _artist = 'artist';
const _artistLocal = 'artist_localized';
const _artistSource = 'artist_source';
const _charter = 'charter';
const _illustrator = 'illustrator';
const _illustratorSource = 'illustrator_source';
const _backgroundPath = 'background_path';
const _musicPath = 'music_path';
const _previewPath = 'preview_path';
const _musicTitle = 'title';
const _musicTitleLocal = 'title_localized';
const _projectID = 'id';

class CreateNewProjectScreen extends StatefulWidget {
  @override
  _CreateNewProjectScreenState createState() => _CreateNewProjectScreenState();
}

class _CreateNewProjectScreenState extends State<CreateNewProjectScreen> {
  bool isModified = false;
  String projectTitle = 'New Project';
  GlobalKey<FormState> formKey;

  setModifiedtoTrue() => isModified = true;
  setProjectTitle(String title) => setState(() =>
      title.isEmpty ? projectTitle = 'New Project' : projectTitle = title);
  setFormKey(GlobalKey<FormState> key) => formKey = key;

  Future<bool> _onWillPop() async {
    if (isModified) {
      return (await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Unsaved changes will be lost'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancel'),
                ),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Yes'),
                ),
              ],
            ),
          )) ??
          false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(projectTitle, overflow: TextOverflow.ellipsis),
          actions: <Widget>[
            FlatButton(
              child: Text('NEXT'),
              onPressed: () {
                if (formKey.currentState.validate()) {}
              },
              textColor: Colors.white,
            ),
          ],
        ),
        body: _ProjectForm(
          setModifiedtoTrue: setModifiedtoTrue,
          setProjectTitle: setProjectTitle,
          setFormKey: setFormKey,
        ),
      ),
    );
  }
}

class _ProjectForm extends StatefulWidget {
  final Function setModifiedtoTrue;
  final Function setProjectTitle;
  final Function(GlobalKey<FormState>) setFormKey;
  _ProjectForm({
    this.setModifiedtoTrue,
    this.setProjectTitle,
    this.setFormKey,
  });

  @override
  _ProjectFormState createState() {
    return _ProjectFormState(
      cbToTrue: setModifiedtoTrue,
      setProjectTitle: setProjectTitle,
      setFormKey: setFormKey,
    );
  }
}

class _ProjectFormState extends State<_ProjectForm> {
  bool isModified;
  final Function cbToTrue;
  final Function(String) setProjectTitle;
  final Function(GlobalKey<FormState>) setFormKey;
  final formKey = GlobalKey<FormState>();
  File _imageFile;
  String _backgroundImagePath = 'Background Image';
  String _musicTextBox = 'Music';
  File _musicFile;

  Map<String, TextEditingController> _controllers = {
    _artist: TextEditingController(),
    _artistLocal: TextEditingController(),
    _artistSource: TextEditingController(),
    _charter: TextEditingController(),
    _illustrator: TextEditingController(),
    _illustratorSource: TextEditingController(),
    _musicTitle: TextEditingController(),
    _musicTitleLocal: TextEditingController(),
    _projectID: TextEditingController(),
  };

  _ProjectFormState({
    this.cbToTrue,
    this.setProjectTitle,
    this.setFormKey,
  });

  RegExp _projectIDRegexTest = new RegExp(
    r"^[\w\.\-\_\~]*$",
    caseSensitive: false,
    multiLine: false,
  ),
      _urlRegexTest = new RegExp(
    r"(^ftp\:\/\/|^https?\:\/\/|^Original)",
    caseSensitive: false,
    multiLine: false,
  );

  TextStyle _hintStyle = TextStyle(
    color: Colors.grey[400],
    fontSize: 13,
  );

  _setImage() async {
    var img = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (img != null) {
      setState(() {
        _backgroundImagePath = 'Image: ' + img.path.split('/').last;
        _imageFile = img;
      });
    } else {
      setState(() {
        _backgroundImagePath = 'Background Image';
      });
    }
  }

  _setMusic() async {
    var music = await FilePicker.getFile(
      type: FileType.audio,
    );
    if (music != null) {
      var filename = music.path.split('/').last;
      if (!filename.endsWith('.mp3')) {
        await showDialog(
          context: context,
          builder: (BuildContext context) => new AlertDialog(
            title: Text('Unsupported File Format'),
            content: Text('Format other than MP3 will be formatted as one.'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
      setState(() {
        _musicTextBox = 'Music: ' + filename;
        _musicFile = music;
      });
    } else {
      setState(() {
        _musicTextBox = 'Music';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setFormKey(formKey);
    for (final k in _controllers.keys) {
      _controllers[k].addListener(() {
        if (_controllers[k].text.isNotEmpty) {
          cbToTrue();
        }
      });
    }
    _controllers[_musicTitle].addListener(() {
      setProjectTitle(_controllers[_musicTitle].text);
    });
  }

  @override
  void dispose() {
    for (final k in _controllers.keys) {
      _controllers[k].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Charter',
                  helperText: 'Required.',
                  hintText: 'Your name',
                  hintStyle: _hintStyle,
                ),
                controller: _controllers[_charter],
                validator: (String value) =>
                    value.isEmpty ? 'Charter is required.' : null,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: _musicTextBox,
                      ),
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      child:
                          Text('Open', style: TextStyle(color: Colors.white)),
                      onPressed: _setMusic,
                      color: Colors.blue,
                    ),
                    margin: EdgeInsets.only(left: 10),
                  ),
                ],
              ),
              _musicFile == null
                  ? GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black87,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        padding: EdgeInsets.all(4),
                        child: Center(child: Text('No Music Set')),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 8,
                      ),
                      onTap: _setImage,
                    )
                  : Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black87,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      padding: EdgeInsets.all(4),
                      // TODO: Set Music Player
                      child: Center(
                        child: Text('Music is set but Player not installed.'),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 8,
                    ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Music Title',
                  helperText: 'Required.',
                  hintText: 'Title (Original language)',
                  hintStyle: _hintStyle,
                ),
                controller: _controllers[_musicTitle],
                validator: (String value) =>
                    value.isEmpty ? 'Music title is required.' : null,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Music Title (Localized)',
                  hintText: 'Title (english)',
                  hintStyle: _hintStyle,
                ),
                controller: _controllers[_musicTitleLocal],
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Music Artist',
                  helperText: 'Required.',
                  hintText: 'Artist (Original Language)',
                  hintStyle: _hintStyle,
                ),
                controller: _controllers[_artist],
                validator: (value) =>
                    value.isEmpty ? 'Music artist is required.' : null,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Music Artist (Localized)',
                  hintText: 'Artist (English)',
                  hintStyle: _hintStyle,
                ),
                controller: _controllers[_artistLocal],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: _backgroundImagePath,
                      ),
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      child:
                          Text('Open', style: TextStyle(color: Colors.white)),
                      onPressed: _setImage,
                      color: Colors.blue,
                    ),
                    margin: EdgeInsets.only(left: 10),
                  ),
                ],
              ),
              _imageFile == null
                  ? GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black87,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        padding: EdgeInsets.all(4),
                        child: Center(child: Text('No Image Set')),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 4,
                      ),
                      onTap: _setImage,
                    )
                  : Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black87,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      padding: EdgeInsets.all(4),
                      child: Image.file(
                        _imageFile,
                        fit: BoxFit.contain,
                      ),
                      width: MediaQuery.of(context).size.width,
                    ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Illustrator Name',
                  helperText: 'Required.',
                  hintText: 'Picture artist name',
                  hintStyle: _hintStyle,
                ),
                controller: _controllers[_illustrator],
                validator: (value) =>
                    value.isEmpty ? 'Illustrator name is required.' : null,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Illutration Source',
                  helperText:
                      'Required. Prepend with "Original" for self-made content.',
                  hintText: 'URL where the image can be found.',
                  hintStyle: _hintStyle,
                ),
                controller: _controllers[_illustratorSource],
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Illustration source cannot be empty';
                  }
                  if (!_urlRegexTest.hasMatch(value)) {
                    return 'Invalid URL. Prepend with "Original" for self made content.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Project ID',
                  helperText: 'Required.',
                  hintText: 'Naming convention: (charter).(music_title)',
                ),
                controller: _controllers[_projectID],
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Project ID is required.';
                  }
                  if (!_projectIDRegexTest.hasMatch(value)) {
                    return 'Project ID only supports Alphanumerics and "_" / "." / "-" / "~"';
                  }
                  return null;
                },
              ),
              Container(
                height: MediaQuery.of(context).size.height / 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
