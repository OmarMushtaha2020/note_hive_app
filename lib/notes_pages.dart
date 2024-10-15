import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController _noteController = TextEditingController();
  late Box notesBox;

  @override
  void initState() {
    super.initState();
    notesBox = Hive.box('notes');
  }

  void _addNote() {
    if (_noteController.text.isNotEmpty) {
      notesBox.add(_noteController.text);
      _noteController.clear();
      setState(() {});
    }
  }

  void _deleteNote(int index) {
    notesBox.deleteAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
