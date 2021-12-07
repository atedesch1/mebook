import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'package:mebook/services/abstract_calendar_service.dart';
import 'package:mebook/services/google_calendar_service.dart';
import 'package:mebook/services/firebase_calendar_service.dart';
import 'package:mebook/services/auth_service.dart';
import 'package:mebook/widgets/schedule/simple_event_tile.dart';
import 'package:mebook/models/event_model.dart';

class TodaysEventsSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AbstractCalendarService calendarService;
    if (context.read<AuthService>().getAuthenticationMethod ==
        Authentication.Google) {
      calendarService = GoogleCalendarService(context);
    } else {
      calendarService = FirebaseCalendarService(context);
    }

    return Container(
      constraints: BoxConstraints(minHeight: 100, maxHeight: 200),
      child: FutureBuilder(
          future: calendarService.getDailyEvents(
            calendarId: 'primary',
            chosenDay: DateTime.now(),
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Event> events = snapshot.data;
              if (events.isEmpty)
                return Center(
                    child: Text(
                  'No events today!',
                  style: TextStyle(fontSize: 20),
                ));
              events.sort((eventA, eventB) =>
                  eventA.startTime.compareTo(eventB.startTime));
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: events.length > 2 ? 1 : 0,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(0),
                      itemBuilder: (context, index) =>
                          SimpleEventTile(event: events[index]),
                      itemCount: events.length,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
