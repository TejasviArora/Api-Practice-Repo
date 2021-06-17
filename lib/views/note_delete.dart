import 'package:flutter/material.dart';

class NoteDelete extends StatelessWidget {

@override
Widget build(BuildContext context) {
  return AlertDialog(
    title: Text("WARNING"),
    content: Text("Are you sure you want to delete"),
    actions: <Widget> [
            FlatButton(
              onPressed: () {Navigator.of(context).pop(true);  },
              child: Text("Yes"),
            ),
      FlatButton(
        onPressed: () {Navigator.of(context).pop(false);   },
        child: Text("no"),
      )
    ],
  );
}}
