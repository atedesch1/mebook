import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mebook/models/note_model.dart';
import 'package:mebook/widgets/edit_note.dart';

class NoteCard extends StatelessWidget {
  final Color _color;
  final Function _toggleDeletingSelect;
  final Function _deleteNote;
  final Function _editNote;
  final Note _note;

  NoteCard(
    this._note,
    this._color,
    this._editNote,
    this._deleteNote,
    this._toggleDeletingSelect,
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _color,
      borderRadius: BorderRadius.circular(20),
      elevation: 6,
      child: InkWell(
        onLongPress: () => _toggleDeletingSelect(_note.id),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) {
              return EditNote(
                id: _note.id,
                oldTitle: _note.title,
                oldContent: _note.content,
                editNote: _editNote,
                deleteNote: _deleteNote,
              );
            },
          ));
        },
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _note.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                _note.content,
                maxLines: 4,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  color: Colors.grey[100],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
