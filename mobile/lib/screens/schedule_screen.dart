import 'package:flutter/material.dart';
import 'package:mebook/services/calendar_service.dart';
import 'package:mebook/widgets/misc/overlay_app_bar.dart';
import 'package:mebook/widgets/schedule/calendar.dart';
import 'package:googleapis/calendar/v3.dart' as googleApis;
import 'package:mebook/widgets/schedule/event_preview_tile.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime focusedDate = DateTime.now();

  void setCurrentDate(DateTime selectedDate) {
    setState(() {
      focusedDate = selectedDate;
    });
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
                  child: Calendar(updateMonth: setCurrentDate),
                ),
                Container(
                  child: FutureBuilder(
                    future:
                        CalendarService(context).getMonthEvents(focusedDate),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        googleApis.Events events = snapshot.data;

                        return Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.all(0),
                            itemBuilder: (context, index) =>
                                EventPreviewTile(events.items[index]),
                            itemCount: events.items.length,
                          ),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    // return Scaffold(body: Calendar());
  }
}
