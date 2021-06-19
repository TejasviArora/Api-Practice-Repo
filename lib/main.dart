import 'package:flutter/material.dart';
import 'package:flutter_api_practice/services/note_services.dart';
import 'package:flutter_api_practice/views/note_list.dart';
import 'package:get_it/get_it.dart';

void setUpLocator(){
  GetIt.I.registerLazySingleton(() => NoteServices());
}

void main() {
  setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: NoteList(),
    );
  }
}

