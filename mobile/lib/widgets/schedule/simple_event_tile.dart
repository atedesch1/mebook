import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'package:mebook/models/event_model.dart';

class SimpleEventTile extends StatelessWidget {
  final Event event;

  SimpleEventTile({@required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 60,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child: Text(
                              DateFormat('M/d kk:mm')
                                  .format(event.startTime),
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              DateFormat('M/d kk:mm')
                                  .format(event.endTime),
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
                    height: 60,
                    color: Colors.cyan,
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
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Status: confirmed',
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
