import 'package:flutter/foundation.dart';
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

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        id: json['id'] as String,
        title: json['title'] as String,
        startTime: json['startTime'] as DateTime,
        endTime: json['endTime'] as DateTime,
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

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'startTime': startTime,
    'endTime': endTime,
  };
}
