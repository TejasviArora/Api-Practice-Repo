import 'package:flutter/material.dart';
import 'package:flutter_api_practice/models/note.dart';
import 'package:flutter_api_practice/services/note_services.dart';
import 'package:get_it/get_it.dart';

class NotesModify extends StatefulWidget {
  final String noteId;
  const NotesModify({Key key, this.noteId}) : super(key: key);

  @override
  _NotesModifyState createState() => _NotesModifyState();
}

class _NotesModifyState extends State<NotesModify> {
  bool get isEditing => widget.noteId != null;

  NoteServices get notesService => GetIt.I<NoteServices>();
  String errorMessage;
  Note note;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    notesService.getNote(widget.noteId).then((response) {
      setState(() {
        _isLoading = false;
      });
      if (response.error) {
        errorMessage = response.errorMessage ?? 'AN error occurred';
      }
      note = response.data;
      _titleController.text = note.noteTitle;
      _contentController.text = note.noteContent;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "create new task" : "modify your task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading ? Center (child: CircularProgressIndicator()) : Column(
          children: [
            TextField(
              controller: _titleController,
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
                if (isEditing) {
                  //update note in api
                } else {
                  //create note in api
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
