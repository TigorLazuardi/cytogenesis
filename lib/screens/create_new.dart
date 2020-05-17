import 'package:flutter/material.dart';

class CreateNewProjectScreen extends StatefulWidget {
  @override
  _CreateNewProjectScreenState createState() => _CreateNewProjectScreenState();
}

class _CreateNewProjectScreenState extends State<CreateNewProjectScreen> {
  Future<bool> _onWillPop() async {
    var formState = _ProjectForm.of(context);
    if (formState?.isModified == true) {
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
        body: _ProjectForm(),
      ),
    );
  }
}

class _ProjectForm extends StatefulWidget {
  static _ProjectFormState of(BuildContext context) =>
      context.findAncestorStateOfType<_ProjectFormState>();

  @override
  _ProjectFormState createState() => _ProjectFormState();
}

class _ProjectFormState extends State<_ProjectForm> {
  bool isModified;
  final _charterController = TextEditingController(),
      _musicTitleController = TextEditingController(),
      _artistController = TextEditingController(),
      _artistLocalizedController = TextEditingController(),
      _projectIDController = TextEditingController(),
      _musicTitleLocalizedController = TextEditingController();

  RegExp _projectIDRegexTest = new RegExp(
    r"^[\w\.\_\-\~]]*$",
    caseSensitive: false,
    multiLine: false,
  );

  final _formKey = GlobalKey<FormState>();

  TextStyle _hintStyle = TextStyle(
    color: Colors.grey[400],
    fontSize: 13,
  );

  TextFormField _buildTextFormField({
    String labelText,
    String helperText,
    String hintText,
    TextEditingController controller,
    String Function(String) validator,
  }) =>
      TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          helperText: helperText,
          hintText: hintText,
          hintStyle: _hintStyle,
        ),
        controller: controller,
      );

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
              controller: _charterController,
              validator: (value) =>
                  value.isEmpty ? "Charter name is required" : null,
            ),
            _buildTextFormField(
              labelText: 'Music Title',
              helperText: 'Required',
              hintText: 'Title (Original Language)',
              controller: _musicTitleController,
              validator: (value) =>
                  value.isEmpty ? "Music title is required" : null,
            ),
            _buildTextFormField(
              labelText: 'Music Title (Localized)',
              hintText: 'Title (English)',
              controller: _musicTitleLocalizedController,
            ),
            _buildTextFormField(
              labelText: 'Artist',
              helperText: 'Required',
              hintText: 'Artist (Original Language)',
              controller: _artistController,
              validator: (value) =>
                  value.isEmpty ? "Music title is required" : null,
            ),
            _buildTextFormField(
              labelText: 'Artst (Localized)',
              hintText: 'Artist (English)',
              controller: _artistLocalizedController,
            ),
            _buildTextFormField(
              labelText: 'Project ID',
              helperText: 'Required',
              hintText: 'Naming convention: (charter).(music_title)',
              controller: _projectIDController,
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
