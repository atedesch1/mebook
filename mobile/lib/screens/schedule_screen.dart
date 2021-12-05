import 'package:flutter/material.dart';
import 'package:mebook/services/calendar_service.dart';
import 'package:mebook/widgets/misc/event_route.dart';
import 'package:mebook/widgets/misc/overlay_app_bar.dart';
import 'package:mebook/widgets/schedule/calendar.dart';
import 'package:googleapis/calendar/v3.dart' as googleApis;
import 'package:mebook/widgets/schedule/edit_event_card.dart';
import 'package:mebook/widgets/schedule/event_preview_tile.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime focusedDate = DateTime.now();
  bool hasUpdated = false;

  void setCurrentDate(DateTime selectedDate) {
    setState(() {
      focusedDate = selectedDate;
    });
  }

  void refreshEventList() {
    setState(() {
      hasUpdated = true;
    });
    hasUpdated = false;
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
                onPressed: () => {
                  Navigator.of(context)
                      .push(ChangeEventRoute(builder: (context) {
                    return EditEventCard(
                      service: CalendarService(context),
                      refreshCallBack: refreshEventList,
                    );
                  }))
                },
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
                Expanded(
                  child: FutureBuilder(
                    future:
                        CalendarService(context).getMonthEvents(focusedDate),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        googleApis.Events events = snapshot.data;
                        if (events.items.isEmpty)
                          return Center(
                            child: Text(
                              'No events for the selected day',
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        return ListView.builder(
                          padding: EdgeInsets.all(0),
                          itemBuilder: (context, index) => EventPreviewTile(
                            event: events.items[index],
                            refreshCallBack: refreshEventList,
                          ),
                          itemCount: events.items.length,
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
  }
}
