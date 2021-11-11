import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mebook/mock/notes_mock.dart';
import 'package:mebook/models/note_model.dart';
import 'package:mebook/widgets/edit_note.dart';
import 'package:mebook/widgets/note_card.dart';

class NotesScreen extends StatefulWidget {
  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final List<Map<String, Object>> _notes = NotesMock().notes;
  final List<int> _selectedToDelete = [];

  void _editNote({int id, @required String title, @required String content}) {
    final editedNote = {
      'id': id ?? Random().nextInt(100),
      'title': title,
      'content': content,
    };

    setState(() {
      if (id == null) {
        _notes.add(editedNote);
      } else {
        _notes.removeWhere((element) => element['id'] == id);
        _notes.add(editedNote);
      }
    });
  }

  void _toggleDeletingSelect(int id) {
    setState(() {
      if (_selectedToDelete.contains(id)) {
        _selectedToDelete.remove(id);
      } else {
        _selectedToDelete.add(id);
      }
    });
  }

  void _deleteNotes() {
    setState(() {
      _notes
          .removeWhere((element) => _selectedToDelete.contains(element['id']));
    });
    _selectedToDelete.clear();
  }

  void _deleteNote(int id) {
    setState(() {
      _notes.removeWhere((element) => element['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Note> notes = _notes
        .map((item) => Note(
              id: item['id'],
              title: item['title'],
              content: item['content'],
            ))
        .toList();

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverAppBar(
            stretch: true,
            onStretchTrigger: () {
              return Future<void>.value();
            },
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              'Notes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) {
                      return EditNote(
                        editNote: _editNote,
                      );
                    },
                  ));
                },
                icon: Icon(Icons.add),
              ),
              if (!_selectedToDelete.isEmpty)
                IconButton(
                  onPressed: _deleteNotes,
                  icon: Icon(Icons.delete),
                )
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            sliver: SliverPadding(
              padding: EdgeInsets.only(top: 5),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => NoteCard(
                          notes[index],
                          _selectedToDelete.contains(notes[index].id)
                              ? Colors.grey
                              : Colors.cyan[300],
                          _editNote,
                          _deleteNote,
                          _toggleDeletingSelect,
                        ),
                    childCount: notes.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.9,
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
