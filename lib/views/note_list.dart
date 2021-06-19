import 'package:flutter/material.dart';
import 'package:flutter_api_practice/models/api_response.dart';
import 'package:flutter_api_practice/models/note_for_listing.dart';
import 'package:flutter_api_practice/views/note_delete.dart';
import 'package:flutter_api_practice/views/notes_modify.dart';
import 'package:get_it/get_it.dart';
import "package:flutter_api_practice/services/note_services.dart";
import "../models/api_response.dart";

class NoteList extends StatefulWidget {

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {

  NoteServices get service => GetIt.I<NoteServices>();
  List<NoteForListing> notes = [];

  APIResponse<List<NoteForListing>> _apiResponse;
  bool _isLoading= false;

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async{
    setState((){
      _isLoading=true;
    });
    _apiResponse= await service.getNotesList();

    setState((){
      _isLoading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of notes"),
      ),
      body:  Builder(
        builder: (_){
          if(_isLoading){return Center(child: Text(_apiResponse.errorMessage));}
          if(_apiResponse.error){return CircularProgressIndicator();}
         return ListView.separated(
            separatorBuilder: (_, index) => Divider(height: 1, color: Colors.black),
            itemBuilder: (_, index) {
              return Dismissible(
                key: ValueKey(_apiResponse.data[index].noteId),
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
                    title: Text(_apiResponse.data[index].noteTitle,
                        style: TextStyle(
                          color: Colors.black,
                        )),
                    subtitle: Text(
                        "last edit on ${formatDateTime(_apiResponse.data[index].lastEditDateTime ?? _apiResponse.data[index].createDateTime)}",
                        style: TextStyle(
                          color: Colors.black,
                        )),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NotesModify(noteId: _apiResponse.data[index].noteId)));
                    }),
              );
            },
            itemCount: _apiResponse.data.length,
          );
        }
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
