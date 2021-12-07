import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'package:mebook/models/event_model.dart';

class SimpleEventTile extends StatelessWidget {
  final Event event;

  SimpleEventTile({@required this.event});

  @override
  Widget build(BuildContext context) {
    Duration timeUntilEvent = event.startTime.difference(DateTime.now());
    Duration timeAfterEvent = event.endTime.difference(DateTime.now());
    String formattedTimeUntilEvent = '';
    if (timeUntilEvent.inHours > 0)
      formattedTimeUntilEvent =
          '${timeUntilEvent.inHours} h ${timeUntilEvent.inMinutes.remainder(60)} m';
    else
      formattedTimeUntilEvent = '${timeUntilEvent.inMinutes} m';

    return Container(
      height: 70,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 80,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child: Text(
                              DateFormat('M/d kk:mm').format(event.startTime),
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              DateFormat('M/d kk:mm').format(event.endTime),
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 3,
                    height: 70,
                    color: Theme.of(context).backgroundColor,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              event.title,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                timeUntilEvent.isNegative
                                    ? timeAfterEvent.isNegative
                                        ? 'Event has ended'
                                        : 'Event has started'
                                    : 'Event starts in $formattedTimeUntilEvent',
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
