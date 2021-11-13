import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mebook/models/event_model.dart';
import 'package:mebook/widgets/calendar_event_route.dart';
import 'package:mebook/widgets/calendar_event_card.dart';
import 'package:intl/intl.dart';

class EventPreviewTile extends StatelessWidget {
  final Event _event;

  EventPreviewTile(this._event);

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
                        _event.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${DateFormat('kk:mm').format(_event.startTime)} - ${DateFormat('kk:mm').format(_event.endTime)}',
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
