import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:mebook/services/calendar_service.dart';
import 'package:mebook/widgets/schedule/simple_event_tile.dart';

class TodaysEventsSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 100, maxHeight: 200),
      child: FutureBuilder(
          future: CalendarService(context).getDailyEvents(DateTime.now()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Events events = snapshot.data;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(0),
                      itemBuilder: (context, index) =>
                          SimpleEventTile(event: events.items[index]),
                      itemCount: events.items.length,
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
