import 'package:flutter/material.dart';
import 'package:flutter_api_practice/models/note_for_listing.dart';

class NoteServices{
  List<NoteForListing> getNotesList(){
  return [
    new NoteForListing(
        noteId: "1",
        createDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now(),
        noteTitle: "Note 1"),
    new NoteForListing(
        noteId: "2",
        createDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now(),
        noteTitle: "Note 2"),
    new NoteForListing(
        noteId: "3",
        createDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now(),
        noteTitle: "Note 3"),
  ];
}
}
