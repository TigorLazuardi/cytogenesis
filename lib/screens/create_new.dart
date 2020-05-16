import 'package:flutter/material.dart';

class CreateNewProjectScreen extends StatefulWidget {
  @override
  _CreateNewProjectScreenState createState() => _CreateNewProjectScreenState();
}

class _CreateNewProjectScreenState extends State<CreateNewProjectScreen> {
  Future<bool> _onWillPop() async {
    var formState = _ProjectForm.of(context);
    if (formState?.modified == true) {
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
  bool modified;
  @override
  Widget build(BuildContext context) {
    return Text('TODO');
  }
}
