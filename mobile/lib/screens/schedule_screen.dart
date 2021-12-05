import 'package:flutter/material.dart';
import 'package:mebook/services/calendar_service.dart';
import 'package:mebook/widgets/misc/event_route.dart';
import 'package:mebook/widgets/misc/overlay_app_bar.dart';
import 'package:mebook/widgets/schedule/calendar.dart';
import 'package:mebook/widgets/schedule/calendar_utils.dart';
import 'package:googleapis/calendar/v3.dart' as googleApis;
import 'package:mebook/widgets/schedule/edit_event_card.dart';
import 'package:mebook/widgets/schedule/event_preview_tile.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime _focusedDate = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  bool hasUpdated = false;

  void setCurrentMonth(DateTime focusedDate) {
    setState(() {
      _focusedDate = focusedDate;
    });
  }

  void setCurrentDate(DateTime selectedDate) {
    setState(() {
      _selectedDate = selectedDate;
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
                  child: Calendar(
                      updateMonth: setCurrentMonth,
                      updateDate: setCurrentDate
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future:
                        CalendarService(context).getDailyEvents(_selectedDate),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        googleApis.Events events = snapshot.data;
                        events.items = events.items.map((e) => addTimeZone(e))
                            .toList();
                        events.items.sort((eventA, eventB) => eventA
                            .start.dateTime
                            .compareTo(eventB.start.dateTime));
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
                            service: CalendarService(context),
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
