import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

const _artist = 'artist';
const _artistLocal = 'artist_localized';
const _artistSource = 'artist_source';
const _charter = 'charter';
const _illustrator = 'illustrator';
const _illustratorSource = 'illustrator_source';
const _musicTitle = 'title';
const _musicTitleLocal = 'title_localized';
const _projectID = 'id';

class CreateNewProjectScreen extends StatefulWidget {
  @override
  _CreateNewProjectScreenState createState() => _CreateNewProjectScreenState();
}

class _CreateNewProjectScreenState extends State<CreateNewProjectScreen> {
  bool isModified = false;

  setModifiedtoTrue() {
    isModified = true;
  }

  setModifiedtoFalse() {
    isModified = false;
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
                  child: new Text('Cancel'),
                ),
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text('Yes'),
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
          title: Text('New Project'),
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
        ),
      ),
    );
  }
}

class _ProjectForm extends StatefulWidget {
  final Function setModifiedtoFalse;
  final Function setModifiedtoTrue;
  _ProjectForm({this.setModifiedtoFalse, this.setModifiedtoTrue});

  @override
  _ProjectFormState createState() {
    return _ProjectFormState(
        cbToFalse: setModifiedtoFalse, cbToTrue: setModifiedtoTrue);
  }
}

class _ProjectFormState extends State<_ProjectForm> {
  bool isModified;
  final Function cbToFalse;
  final Function cbToTrue;
  final formKey = GlobalKey<FormState>();

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

  _ProjectFormState({this.cbToFalse, this.cbToTrue});

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
          ],
        ),
      ),
    );
  }
}
