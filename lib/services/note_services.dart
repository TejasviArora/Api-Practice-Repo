import 'dart:convert';
import 'package:flutter_api_practice/models/api_response.dart';
import 'package:flutter_api_practice/models/note.dart';
import 'package:flutter_api_practice/models/note_for_listing.dart';
import "package:flutter_api_practice/models/note.dart";
import 'package:http/http.dart' as http;

class NoteServices {
  static const API = "https://tq-notes-api-jkrgrdggbq-el.a.run.app/";
  static const headers = {
    'apiKey': "ac292dc8-a438-4711-aca7-4b2991fea176",
  };

  Future<APIResponse<List<NoteForListing>>> getNotesList() {
    return http.get(API + '/notes', headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        List notes = <NoteForListing>[];
          for(var item in jsonData) {
            notes.add(NoteForListing.fromJson(item));
        };
        return APIResponse<List<NoteForListing>>(data:notes);
      }
      return APIResponse<List<NoteForListing>>(error : true, errorMessage: "an error occured");
    }).catchError((_) => APIResponse<List<NoteForListing>>(error : true, errorMessage: "an error occured"));
  }
  Future<APIResponse<Note>> getNote(String noteId) {
    return http.get(API + '/notes/' + noteId, headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        return APIResponse<Note>(data:Note.fromJson(jsonData));
      }
      return APIResponse<Note>(error : true, errorMessage: "an error occured");
    }).catchError((_) => APIResponse<Note>(error : true, errorMessage: "an error occured"));
  }
}

