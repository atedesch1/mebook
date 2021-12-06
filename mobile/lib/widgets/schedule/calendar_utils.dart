import 'package:googleapis/calendar/v3.dart' as googleCalendar;
import 'package:flutter/material.dart';

class TimeAggregate {
  DateTime startDate;
  TimeOfDay startTime;
  DateTime endDate;
  TimeOfDay endTime;
  TimeAggregate(this.startDate, this.startTime, this.endDate, this.endTime);
}

googleCalendar.Event addTimeZone(googleCalendar.Event e) {
  e.start.dateTime = e.start.dateTime.toLocal();
  e.end.dateTime = e.end.dateTime.toLocal();
  return e;
}

googleCalendar.Event removeTimeZone(googleCalendar.Event e) {
  e.start.dateTime = e.start.dateTime.toUtc();
  e.end.dateTime = e.end.dateTime.toUtc();
  return e;
}

DateTime joinDateTime(DateTime date, TimeOfDay timeOfDay) {
  return DateTime(
    date.year,
    date.month,
    date.day,
    timeOfDay.hour,
    timeOfDay.minute,
  );
}

DateTime extractDate(DateTime d) {
  return DateTime(d.year, d.month, d.day);
}

TimeOfDay extractTimeOfDay(DateTime d) {
  return TimeOfDay.fromDateTime(d);
}

TimeAggregate adjustBeginToEnd(TimeAggregate timeAgg) {
  DateTime begin = joinDateTime(timeAgg.startDate, timeAgg.startTime);
  DateTime end = joinDateTime(timeAgg.endDate, timeAgg.endTime);
  if (begin.isBefore(end)) {
    return timeAgg;
  }
  DateTime adjustedBegin = end.subtract(Duration(hours: 1));
  timeAgg.startDate = extractDate(adjustedBegin);
  timeAgg.startTime = extractTimeOfDay(adjustedBegin);
  return timeAgg;
}

TimeAggregate adjustEndToBegin(TimeAggregate timeAgg) {
  DateTime begin = joinDateTime(timeAgg.startDate, timeAgg.startTime);
  DateTime end = joinDateTime(timeAgg.endDate, timeAgg.endTime);
  if (begin.isBefore(end)) {
    return timeAgg;
  }
  DateTime adjustedEnd = begin.add(Duration(hours: 1));
  timeAgg.endDate = extractDate(adjustedEnd);
  timeAgg.endTime = extractTimeOfDay(adjustedEnd);
  return timeAgg;
}