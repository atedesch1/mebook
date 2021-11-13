import 'package:flutter/foundation.dart';

class Event {
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final bool notify;

  Event(
      {@required this.id,
      @required this.title,
      @required this.startTime,
      @required this.endTime,
      @required this.notify});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        id: json['id'] as String,
        title: json['title'] as String,
        startTime: json['startTime'] as DateTime,
        endTime: json['endTime'] as DateTime,
        notify: json['notify'] as bool);
  }
}
