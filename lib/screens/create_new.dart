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
  GlobalKey<FormState> formKey;
  String projectTitle = 'New Project';

  setModifiedtoTrue() {
    isModified = true;
  }

  setModifiedtoFalse() {
    isModified = false;
  }

  setGlobalKey(GlobalKey<FormState> key) {
    formKey = key;
  }

  setProjectTitle(String title) {
    setState(() {
      if (title.isEmpty) {
        projectTitle = 'New Project';
      } else {
        projectTitle = title;
      }
    });
  }

  Future<bool> _onWillPop() async {
    if (isModified) {
      return (await showDialog(
            context: context,
            builder: (BuildContext context) => new AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Unsaved changes will be lost'),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancel'),
                ),
                new FlatButton(
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
              child: Text(
                'NEXT',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: _ProjectForm(
          setModifiedtoFalse: setModifiedtoFalse,
          setModifiedtoTrue: setModifiedtoTrue,
          setProjectTitle: setProjectTitle,
        ),
      ),
    );
  }
}

class _ProjectForm extends StatefulWidget {
  final Function setModifiedtoFalse;
  final Function setModifiedtoTrue;
  final Function setProjectTitle;
  _ProjectForm(
      {this.setModifiedtoFalse, this.setModifiedtoTrue, this.setProjectTitle});

  @override
  _ProjectFormState createState() {
    return _ProjectFormState(
        cbToFalse: setModifiedtoFalse,
        cbToTrue: setModifiedtoTrue,
        setProjectTitle: setProjectTitle);
  }
}

class _ProjectFormState extends State<_ProjectForm> {
  bool isModified;
  final Function cbToFalse;
  final Function cbToTrue;
  final Function(String) setProjectTitle;
  final formKey = GlobalKey<FormState>();
  File _imageFile;
  String _backgroundImagePath = 'Background Image';
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
    _backgroundPath: TextEditingController(),
    _musicPath: TextEditingController(),
    _previewPath: TextEditingController(),
    _projectID: TextEditingController(),
  };

  _ProjectFormState({this.cbToFalse, this.cbToTrue, this.setProjectTitle});

  RegExp _projectIDRegexTest = new RegExp(
    r"^[\w\.\_\-\~]]*$",
    caseSensitive: false,
    multiLine: false,
  );

  TextStyle _hintStyle = TextStyle(
    color: Colors.grey[400],
    fontSize: 13,
  );

  TextFormField _buildTextFormField({
    @required String labelText,
    @required TextEditingController controller,
    String helperText,
    String hintText,
    String Function(String) validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        helperText: helperText,
        hintText: hintText,
        hintStyle: _hintStyle,
      ),
      controller: controller,
    );
  }

  _setImage() async {
    var img = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (img != null) {
      _controllers[_musicPath].text = img.path;
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

  @override
  void initState() {
    super.initState();
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
    return Form(
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: ListView(
          children: <Widget>[
            _buildTextFormField(
              labelText: 'Charter',
              helperText: 'Required',
              hintText: 'Your Name',
              controller: _controllers[_charter],
              validator: (value) =>
                  value.isEmpty ? "Charter name is required" : null,
            ),
            _buildTextFormField(
              labelText: 'Music Title',
              helperText: 'Required',
              hintText: 'Title (Original Language)',
              controller: _controllers[_musicTitle],
              validator: (value) =>
                  value.isEmpty ? "Music title is required" : null,
            ),
            _buildTextFormField(
              labelText: 'Music Title (Localized)',
              hintText: 'Title (English)',
              controller: _controllers[_musicTitleLocal],
            ),
            _buildTextFormField(
              labelText: 'Music Artist',
              helperText: 'Required',
              hintText: 'Artist (Original Language)',
              controller: _controllers[_artist],
              validator: (value) =>
                  value.isEmpty ? "Music title is required" : null,
            ),
            _buildTextFormField(
              labelText: 'Music Artist (Localized)',
              hintText: 'Artist (English)',
              controller: _controllers[_artistLocal],
            ),
            _buildTextFormField(
              labelText: 'Project ID',
              helperText: 'Required',
              hintText: 'Naming convention: (charter).(music_title)',
              controller: _controllers[_projectID],
              validator: (value) {
                if (value.isEmpty) {
                  return 'Project ID is required';
                }
                if (!_projectIDRegexTest.hasMatch(value)) {
                  return 'Project ID only supports Alphanumerics and "_" / "." / "-" / "~"';
                }
                return null;
              },
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
                    child: Text('Open', style: TextStyle(color: Colors.white)),
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
          ],
        ),
      ),
    );
  }
}
