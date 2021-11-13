import 'package:flutter/material.dart';
import 'package:mebook/mock/events_mock.dart';
import 'package:mebook/models/event_model.dart';
import 'package:mebook/widgets/calendar.dart';
import 'package:mebook/widgets/event_preview_tile.dart';

class ScheduleScreen extends StatelessWidget {
  final List<Event> _events = EventsMock()
      .events
      .map(
        (e) => Event(
          id: e['id'],
          title: e['title'],
          startTime: DateTime.parse(e['startTime']),
          endTime: DateTime.parse(e['endTime']),
          notify: e['notify'],
        ),
      )
      .toList();

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
          SliverFillRemaining(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(2, 3),
                      ),
                    ],
                  ),
                  child: Calendar(),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemBuilder: (context, index) =>
                        EventPreviewTile(_events[index]),
                    itemCount: _events.length,
                  ),
                ),
              ],
            ),
          ),
          // SliverPadding(
          //   padding: EdgeInsets.symmetric(horizontal: 5),
          //   sliver: SliverToBoxAdapter(
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(vertical: 8.0),
          //       child: Container(
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(20),
          //           color: Theme.of(context).primaryColor,
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.black.withOpacity(0.05),
          //               spreadRadius: 3,
          //               blurRadius: 10,
          //               offset: Offset(2, 3),
          //             ),
          //           ],
          //         ),
          //         child: Calendar(),
          //       ),
          //     ),
          //   ),
          // ),
          // SliverList(
          //   delegate: SliverChildBuilderDelegate((context, index) {
          //     return EventPreviewTile(_events[index]);
          //   }, childCount: _events.length),
          // ),
        ],
      ),
    );

    // return Scaffold(body: Calendar());
  }
}
