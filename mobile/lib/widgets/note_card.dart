import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mebook/models/note_model.dart';

class NoteCard extends StatelessWidget {
  final Note _note;
  NoteCard(this._note);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      borderRadius: BorderRadius.circular(20),
      elevation: 6,
      child: InkWell(
        onTap: () {},
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
                style: TextStyle(color: Colors.grey[100], fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
