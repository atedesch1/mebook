import 'package:flutter/material.dart';

class NotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Center(
            child: Text('Notes'),
          ),
        ],
      ),
    );
  }
}
