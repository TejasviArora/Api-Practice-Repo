import 'package:flutter/material.dart';

class NotesModify extends StatelessWidget {

  final String noteId;
  bool get isEditing => noteId !=null;

  const NotesModify({Key key, this.noteId}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing? "create new task" : "modify your task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Type here your task",
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Type here your task",
              ),
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              child: Text("Submit here", style: TextStyle(color: Colors.white)),
              color: Colors.red,
              onPressed: () {
                if(isEditing){
                  //update note in api
                }
                else{//create note in api
                   }
              },
            ),
          ],
        ),
      ),
    );
  }
}
