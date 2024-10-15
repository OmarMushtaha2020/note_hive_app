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
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                labelText: 'Enter your note',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _addNote,
            child: const Text('Add Note'),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: notesBox.listenable(),
              builder: (context, Box box, _) {
                if (box.isEmpty) {
                  return const Center(child: Text('No notes yet!'));
                }

                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(box.getAt(index) as String),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteNote(index),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
