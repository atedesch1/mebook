import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'package:mebook/services/abstract_calendar_service.dart';
import 'package:mebook/widgets/misc/event_route.dart';
import 'package:mebook/widgets/schedule/edit_event_card.dart';
import 'package:mebook/models/event_model.dart';
import 'package:mebook/widgets/schedule/calendar_utils.dart';

class EventPreviewTile extends StatelessWidget {
  final String selectedCalendarId;
  final AbstractCalendarService service;
  final Event event;
  final Function refreshCallBack;

  EventPreviewTile({
    @required this.selectedCalendarId,
    @required this.service,
    @required this.event,
    @required this.refreshCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () =>
            Navigator.of(context).push(ChangeEventRoute(builder: (context) {
          return EditEventCard(
            selectedCalendarId: selectedCalendarId,
            event: event,
            service: service,
            refreshCallBack: refreshCallBack,
          );
        })),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 20,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              '${format(event.startTime)} -',
                              style: TextStyle(color: Colors.black87),
                            ),
                            Text(
                              ' ${format(event.endTime)}',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.edit),
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
          ],
        ),
      ),
    );
  }
}
