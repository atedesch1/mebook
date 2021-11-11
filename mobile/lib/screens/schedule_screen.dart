import 'package:flutter/material.dart';
import 'package:mebook/widgets/calendar.dart';

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
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add),
              ),
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            sliver: SliverToBoxAdapter(
              child: Calendar(),
            ),
          ),
        ],
      ),
    );

    // return Scaffold(body: Calendar());
  }
}
