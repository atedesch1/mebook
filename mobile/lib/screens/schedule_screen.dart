import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              'Schedule',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            actions: [],
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text('Schedule'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
