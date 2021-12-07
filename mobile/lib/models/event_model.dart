import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:googleapis/calendar/v3.dart' as googleCalendar;

class Event {
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;

  Event({
    @required this.id,
    @required this.title,
    @required this.startTime,
    @required this.endTime,
  });

  factory Event.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return Event(
        id: doc.id,
        title: data['title'] as String,
        startTime: DateTime.parse(data['startTime']),
        endTime: DateTime.parse(data['endTime']),
    );
  }

  factory Event.fromGoogle(googleCalendar.Event e) {
    return Event(
      id: e.id,
      title: e.summary,
      startTime: e.start.dateTime,
      endTime: e.end.dateTime,
    );
  }

  googleCalendar.Event toGoogle() => googleCalendar.Event(
    id: id,
    summary: title,
    start: googleCalendar.EventDateTime(dateTime: startTime),
    end: googleCalendar.EventDateTime(dateTime: endTime),
  );

  Map<String, dynamic> toFirestore() => {
    'title': title,
    'startTime': startTime.toString(),
    'endTime': endTime.toString(),
  };
}
