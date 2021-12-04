import 'package:flutter/material.dart';
import 'package:mebook/mock/events_mock.dart';
import 'package:mebook/models/event_model.dart';
import 'package:mebook/services/calendar_service.dart';
import 'package:mebook/widgets/misc/overlay_app_bar.dart';
import 'package:mebook/widgets/schedule/calendar.dart';
import 'package:googleapis/calendar/v3.dart' as googleApis;
import 'package:mebook/widgets/schedule/event_preview_tile.dart';

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

  DateTime _selectedMonth = DateTime.now();
  void setSelectedMonth(DateTime newMonth) {
    _selectedMonth = newMonth;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          OverlayAppBar(
            title: 'Schedule',
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
                  child: StreamBuilder(
                    stream: CalendarService(context)
                        .getEventsForMonth(DateTime.now()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print(snapshot.data);
                        googleApis.Events events = snapshot.data;
                        events.items.forEach((e) => print(e.start.dateTime));
                        print(_selectedMonth);
                        return Text('LOADED');
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
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
                  child: Calendar(updateMonth: setSelectedMonth),
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
