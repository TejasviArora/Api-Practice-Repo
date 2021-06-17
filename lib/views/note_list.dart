import 'package:flutter/material.dart';
import 'package:flutter_api_practice/models/note_for_listing.dart';
import 'package:flutter_api_practice/views/note_delete.dart';
import 'package:flutter_api_practice/views/notes_modify.dart';
import 'package:get_it/get_it.dart';
import "package:flutter_api_practice/services/note_services.dart";

class NoteList extends StatefulWidget {

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {

  NoteServices get service => GetIt.I<NoteServices>();
  List<NoteForListing> notes = [];

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    notes= service.getNotesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of notes"),
      ),
      body: ListView.separated(
        separatorBuilder: (_, index) => Divider(height: 1, color: Colors.black),
        itemBuilder: (_, index) {
          return Dismissible(
            key: ValueKey(notes[index].noteId),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {},
            confirmDismiss: (direction) async{
              final result= await showDialog(
                context: context,
                  builder: (_) => NoteDelete()
              );
              return result;
            },

            background: Container(
              color: Colors.red,
              padding: EdgeInsets.only(left: 16),
              child: Align(child: Icon(Icons.delete, color: Colors.white), alignment: Alignment.centerLeft,),
            ),

            child: ListTile(
                title: Text(notes[index].noteTitle,
                    style: TextStyle(
                      color: Colors.black,
                    )),
                subtitle: Text(
                    "last edit on ${formatDateTime(notes[index].lastEditDateTime)}",
                    style: TextStyle(
                      color: Colors.black,
                    )),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NotesModify(noteId: notes[index].noteId)));
                }),
          );
        },
        itemCount: notes.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NotesModify()));
        },
      ),
    );
  }
}
