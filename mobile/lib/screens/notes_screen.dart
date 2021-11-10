import 'package:flutter/material.dart';
import 'package:mebook/mock/notes_mock.dart';
import 'package:mebook/models/note_model.dart';
import 'package:mebook/widgets/note_card.dart';

class NotesScreen extends StatelessWidget {
  final List<Map<String, Object>> _notes = NotesMock().notes;

  @override
  Widget build(BuildContext context) {
    final List<Note> notes = _notes
        .map((item) => Note(title: item['title'], content: item['content']))
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
              IconButton(onPressed: () {}, icon: Icon(Icons.add)),
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            sliver: SliverPadding(
              padding: EdgeInsets.only(top: 5),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => NoteCard(notes[index]),
                    childCount: notes.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
