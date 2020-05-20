import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:CytoGenesis/glossary.dart';

class CreateNewProjectScreen extends StatefulWidget {
  @override
  _CreateNewProjectScreenState createState() => _CreateNewProjectScreenState();
}

class _CreateNewProjectScreenState extends State<CreateNewProjectScreen> {
  bool _isModified = false;
  String _projectTitle = 'New Project';
  GlobalKey<FormState> _formKey;
  File _musicFile;
  File _backgroundImageFile;
  Map<String, TextEditingController> _formValues;

  setModifiedtoTrue() => _isModified = true;
  setProjectTitle(String title) => setState(() =>
      title.isEmpty ? _projectTitle = 'New Project' : _projectTitle = title);
  setFormKey(GlobalKey<FormState> key) => _formKey = key;
  setMusicFile(File music) => _musicFile = music;
  setBackgroundImageFile(File image) => _backgroundImageFile = image;
  getFormValues(Map<String, TextEditingController> fv) => _formValues = fv;

  Future<bool> _onWillPop() async {
    if (_isModified) {
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
          title: Text(_projectTitle, overflow: TextOverflow.ellipsis),
          actions: <Widget>[
            // Need to use child context level to get Scaffold parent
            Builder(
              builder: (context) => FlatButton(
                child: Text('NEXT'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    if (_musicFile == null) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Please select a music.')),
                      );
                      return;
                    }
                    if (_backgroundImageFile == null) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Please select background image.')),
                      );
                      return;
                    }
                    // TODO: Change this snackbar to navigate to other page
                    Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('OK')),
                    );
                  }
                },
                textColor: Colors.white,
              ),
            ),
          ],
        ),
        body: _ProjectForm(
          setModifiedtoTrue: setModifiedtoTrue,
          setProjectTitle: setProjectTitle,
          setFormKey: setFormKey,
          setMusicFile: setMusicFile,
          setBackgroundImageFile: setBackgroundImageFile,
          getFormValues: getFormValues,
        ),
      ),
    );
  }
}

class _ProjectForm extends StatefulWidget {
  final Function setModifiedtoTrue;
  final Function setProjectTitle;
  final Function(GlobalKey<FormState>) setFormKey;
  final Function(File) setMusicFile;
  final Function(File) setBackgroundImageFile;
  final Function(Map<String, TextEditingController>) getFormValues;
  _ProjectForm({
    this.setModifiedtoTrue,
    this.setProjectTitle,
    this.setFormKey,
    this.setMusicFile,
    this.setBackgroundImageFile,
    this.getFormValues,
  });

  @override
  _ProjectFormState createState() {
    return _ProjectFormState(
      setModifiedtoTrue: setModifiedtoTrue,
      setProjectTitle: setProjectTitle,
      setFormKey: setFormKey,
      setMusicFile: setMusicFile,
      setBackgroundImageFile: setBackgroundImageFile,
      getFormValues: getFormValues,
    );
  }
}

class _ProjectFormState extends State<_ProjectForm> {
  final Function setModifiedtoTrue;
  final Function(String) setProjectTitle;
  final Function(GlobalKey<FormState>) setFormKey;
  final Function(File) setMusicFile;
  final Function(File) setBackgroundImageFile;
  final Function(Map<String, TextEditingController>) getFormValues;

  _ProjectFormState({
    this.setModifiedtoTrue,
    this.setProjectTitle,
    this.setFormKey,
    this.setMusicFile,
    this.setBackgroundImageFile,
    this.getFormValues,
  });

  final formKey = GlobalKey<FormState>();
  File _imageFile;
  String _backgroundImageTextBox = 'Background Image';
  String _musicTextBox = 'Music';
  File _musicFile;

  Map<String, TextEditingController> _controllers = {
    LEVEL_ARTIST: TextEditingController(),
    LEVEL_ARTIST_LOCAL: TextEditingController(),
    LEVEL_ARTIST_SOURCE: TextEditingController(),
    LEVEL_CHARTER: TextEditingController(),
    LEVEL_ILLUSTRATOR: TextEditingController(),
    LEVEL_ILLUSTRATOR_SOURCE: TextEditingController(),
    LEVEL_MUSIC_TITLE: TextEditingController(),
    LEVEL_MUSIC_TITLE_LOCAL: TextEditingController(),
    LEVEL_PROJECT_ID: TextEditingController(),
  };

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
      setBackgroundImageFile(img);
      setState(() {
        _backgroundImageTextBox = 'Image: ' + img.path.split('/').last;
        _imageFile = img;
      });
    } else {
      setState(() {
        _backgroundImageTextBox = 'Background Image';
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
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('File other than MP3 will be formatted as one.'),
          ),
        );
      }
      setMusicFile(music);
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
          setModifiedtoTrue();
        }
      });
    }
    _controllers[LEVEL_MUSIC_TITLE].addListener(() {
      setProjectTitle(_controllers[LEVEL_MUSIC_TITLE].text);
    });
    getFormValues(_controllers);
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
                controller: _controllers[LEVEL_CHARTER],
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
                controller: _controllers[LEVEL_MUSIC_TITLE],
                validator: (String value) =>
                    value.isEmpty ? 'Music title is required.' : null,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Music Title (Localized)',
                  hintText: 'Title (english)',
                  hintStyle: _hintStyle,
                ),
                controller: _controllers[LEVEL_MUSIC_TITLE_LOCAL],
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Music Artist',
                  helperText: 'Required.',
                  hintText: 'Artist (Original Language)',
                  hintStyle: _hintStyle,
                ),
                controller: _controllers[LEVEL_ARTIST],
                validator: (value) =>
                    value.isEmpty ? 'Music artist is required.' : null,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Music Artist (Localized)',
                  hintText: 'Artist (English)',
                  hintStyle: _hintStyle,
                ),
                controller: _controllers[LEVEL_ARTIST_LOCAL],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: _backgroundImageTextBox,
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
                controller: _controllers[LEVEL_ILLUSTRATOR],
                validator: (value) =>
                    value.isEmpty ? 'Illustrator name is required.' : null,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Illutration Source',
                  helperText: 'Required. Use "Original" for self-made content.',
                  hintText: 'URL where the image can be found.',
                  hintStyle: _hintStyle,
                ),
                controller: _controllers[LEVEL_ILLUSTRATOR_SOURCE],
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Illustration source cannot be empty';
                  }
                  if (!_urlRegexTest.hasMatch(value)) {
                    return 'Invalid URL. Use "Original" for self made content.';
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
                controller: _controllers[LEVEL_PROJECT_ID],
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
