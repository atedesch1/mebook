import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Center(
            child: Text('Schedule'),
          ),
        ],
      ),
    );
  }
}
