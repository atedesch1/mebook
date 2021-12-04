import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:googleapis/calendar/v3.dart' as calendarApi;
import 'package:mebook/widgets/misc/event_route.dart';
import 'package:mebook/widgets/schedule/calendar_event_card.dart';
import 'package:intl/intl.dart';

class EventPreviewTile extends StatelessWidget {
  final calendarApi.Event event;

  EventPreviewTile(this.event);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 8,
              bottom: 8,
              left: 20,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.summary,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${DateFormat('kk:mm').format(event.start.dateTime)} - ${DateFormat('kk:mm').format(event.end.dateTime)}',
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => {
                    Navigator.of(context)
                        .push(ChangeEventRoute(builder: (context) {
                      return CalendarEventCard();
                    }))
                  },
                  icon: Icon(Icons.edit),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}
