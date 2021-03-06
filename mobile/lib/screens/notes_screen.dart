import 'package:flutter/material.dart';
import 'package:mebook/models/note_model.dart';
import 'package:mebook/services/notes_service.dart';
import 'package:mebook/widgets/misc/overlay_app_bar.dart';
import 'package:mebook/widgets/notes/edit_note.dart';
import 'package:mebook/widgets/notes/note_card.dart';

class NotesScreen extends StatefulWidget {
  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final List<String> _selectedToDelete = [];
  bool isLoading = false;

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

  void _deleteNotes(NotesService notesService) async {
    if (!isLoading) {
      isLoading = true;
      try {
        for (var id in _selectedToDelete) await notesService.deleteNote(id);
        setState(() {
          _selectedToDelete.clear();
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e}')),
        );
      }
      isLoading = false;
    }
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
        backgroundColor: Theme.of(context).backgroundColor,
        child: Icon(Icons.add),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          OverlayAppBar(
            title: 'Notes',
            actions: [
              IconButton(
                key: ValueKey("addNoteButton"),
                onPressed: () => _pushAddNotePage(
                  notesService: notesService,
                  context: context,
                ),
                icon: Icon(Icons.add),
              ),
              if (!_selectedToDelete.isEmpty)
                IconButton(
                  key: ValueKey("deleteNoteButton"),
                  onPressed: () => _deleteNotes(notesService),
                  icon: Icon(Icons.delete),
                ),
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
                          style: TextStyle(fontSize: 20),
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
                      child: CircularProgressIndicator(
                          key: ValueKey("noteScreenLoading")),
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
