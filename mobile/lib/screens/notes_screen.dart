import 'package:flutter/material.dart';
import 'package:mebook/models/note_model.dart';
import 'package:mebook/services/notes_service.dart';
import 'package:mebook/widgets/edit_note.dart';
import 'package:mebook/widgets/note_card.dart';

class NotesScreen extends StatefulWidget {
  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final List<String> _selectedToDelete = [];

  void _pushAddNotePage({
    NotesService notesService,
    BuildContext context,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) {
        return EditNote(editNote: notesService.createOrUpdateNote);
      }),
    );
  }

  void _toggleSelectedForDelete(String id) {
    setState(() {
      if (_selectedToDelete.contains(id)) {
        _selectedToDelete.remove(id);
      } else {
        _selectedToDelete.add(id);
      }
    });
  }

  void _deleteNotes(NotesService notesService) {
    for (var id in _selectedToDelete) notesService.deleteNote(id);

    setState(() {
      _selectedToDelete.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final NotesService notesService = NotesService(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _pushAddNotePage(
          notesService: notesService,
          context: context,
        ),
        backgroundColor: Colors.cyan,
        child: Icon(Icons.add),
      ),
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
                onPressed: () => _pushAddNotePage(
                  notesService: notesService,
                  context: context,
                ),
                icon: Icon(Icons.add),
              ),
              if (!_selectedToDelete.isEmpty)
                IconButton(
                  onPressed: () => _deleteNotes(notesService),
                  icon: Icon(Icons.delete),
                )
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.all(8),
            sliver: StreamBuilder<List<Note>>(
              stream: NotesService(context).getNotes(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var notes = snapshot.data;
                  if (notes.isEmpty) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text(
                          'You have no notes!',
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    );
                  }
                  notes
                      .sort((noteA, noteB) => noteB.time.compareTo(noteA.time));

                  return SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => NoteCard(
                              notes[index],
                              _selectedToDelete.contains(notes[index].id)
                                  ? Colors.grey
                                  : Colors.white,
                              notesService.createOrUpdateNote,
                              notesService.deleteNote,
                              _toggleSelectedForDelete,
                            ),
                        childCount: notes.length),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.9,
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                  );
                } else {
                  return SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
