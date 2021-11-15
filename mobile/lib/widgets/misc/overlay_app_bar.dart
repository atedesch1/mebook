import 'package:flutter/material.dart';

class OverlayAppBar extends StatelessWidget {
  final String title;
  final List<Widget> actions;

  OverlayAppBar({this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      stretch: true,
      onStretchTrigger: () {
        return Future<void>.value();
      },
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      actions: actions,
    );
  }
}
