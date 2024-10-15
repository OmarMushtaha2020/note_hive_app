import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_hive_app/notes_pages.dart';

void main()async{
  await Hive.initFlutter();
  await Hive.openBox('notes'); // Open a Hive box for notes
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NotesPage(),
    );
  }
}
