import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late Box notesBox;
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    notesBox = Hive.box('notes');
  }

  void _addNote() {
    if (_noteController.text.isNotEmpty) {
      notesBox.add(_noteController.text);
      _noteController.clear();
      Navigator.pop(context); // Close the bottom sheet after adding a note
      setState(() {});
    }
  }

  void _deleteNote(int index) {
    notesBox.deleteAt(index);
    setState(() {});
  }

  void _showAddNoteBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Add a New Note',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _noteController,
                decoration: InputDecoration(
                  labelText: 'Enter your note',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addNote,
                child: const Text('Add Note'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: notesBox.listenable(),
                builder: (context, Box box, _) {
                  if (box.isEmpty) {
                    return const Center(child: Text('No notes yet!', style: TextStyle(fontSize: 18)));
                  }

                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        elevation: 4,
                        child: ListTile(
                          title: Text(box.getAt(index) as String, style: const TextStyle(fontSize: 16)),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteNote(index),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddNoteBottomSheet,
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
