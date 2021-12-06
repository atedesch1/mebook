import 'package:flutter/material.dart';
import 'package:mebook/widgets/schedule/select_calendar_card.dart';
import 'package:provider/src/provider.dart';

import 'package:mebook/services/abstract_calendar_service.dart';
import 'package:mebook/services/google_calendar_service.dart';
import 'package:mebook/services/firebase_calendar_service.dart';
import 'package:mebook/services/auth_service.dart';
import 'package:mebook/widgets/misc/event_route.dart';
import 'package:mebook/widgets/misc/overlay_app_bar.dart';
import 'package:mebook/widgets/schedule/calendar.dart';
import 'package:mebook/widgets/schedule/edit_event_card.dart';
import 'package:mebook/widgets/schedule/event_preview_tile.dart';
import 'package:mebook/models/event_model.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime _focusedDate = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  MapEntry<String, Map<String, dynamic>> selectedCalendar =
      MapEntry('primary', {'name': 'Default', 'isPrimary': true});
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
    AbstractCalendarService calendarService;
    if (context.read<AuthService>().getAuthenticationMethod ==
        Authentication.Google) {
      calendarService = GoogleCalendarService(context);
    } else {
      calendarService = FirebaseCalendarService(context);
    }
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
                      service: calendarService,
                      refreshCallBack: refreshEventList,
                    );
                  }))
                },
                icon: Icon(Icons.add),
              ),
              FutureBuilder(
                  future: calendarService.getCalendars(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Map<String, Map<String, dynamic>> calendars =
                          snapshot.data;
                      calendars.remove(
                          context.read<AuthService>().currentUser.email);
                      calendars['primary'] = {
                        'name': 'Default',
                        'isPrimary': true
                      };
                      return IconButton(
                        onPressed: () => Navigator.of(context)
                            .push(ChangeEventRoute(builder: (context) {
                          return SelectCalendarCard(
                            previouslySelected: selectedCalendar,
                            calendars: calendars,
                            selectCalendarFunction: (calendar) => setState(() {
                              selectedCalendar = calendar;
                            }),
                          );
                        })),
                        icon: Icon(Icons.more_vert),
                      );
                    }
                    return IconButton(
                        onPressed: () => {}, icon: Icon(Icons.more_vert));
                  })
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
                      updateMonth: setCurrentMonth, updateDate: setCurrentDate),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: calendarService.getDailyEvents(_selectedDate),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Event> events = snapshot.data;
                        events.sort((eventA, eventB) =>
                            eventA.startTime.compareTo(eventB.startTime));
                        if (events.isEmpty)
                          return Center(
                            child: Text(
                              'No events for the selected day',
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        return ListView.builder(
                          padding: EdgeInsets.all(0),
                          itemBuilder: (context, index) => EventPreviewTile(
                            service: calendarService,
                            event: events[index],
                            refreshCallBack: refreshEventList,
                          ),
                          itemCount: events.length,
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
