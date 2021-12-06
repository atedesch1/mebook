import 'package:googleapis/calendar/v3.dart' as googleCalendar;
import 'package:flutter/material.dart';

DateTime past = DateTime.parse("2000-01-01 00:00:00Z");
DateTime future = DateTime.parse("3000-01-01 00:00:00Z");

enum Scope {
  StartDate,
  StartTime,
  EndDate,
  EndTime
}

class TimeAggregate {
  Map<Scope, dynamic> m;
  TimeAggregate(startDate, startTime, endDate, endTime) {
    m = <Scope, dynamic>{
      Scope.StartDate: startDate,
      Scope.StartTime: startTime,
      Scope.EndDate: endDate,
      Scope.EndTime: endTime,
    };
  }
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

TimeAggregate adjustBeginToEnd(TimeAggregate agg) {
  DateTime begin = joinDateTime(
      agg.m[Scope.StartDate],
      agg.m[Scope.StartTime]
  );
  DateTime end = joinDateTime(agg.m[Scope.EndDate], agg.m[Scope.EndTime]);
  if (begin.isBefore(end)) {
    return agg;
  }
  DateTime adjustedBegin = end.subtract(Duration(hours: 1));
  agg.m[Scope.StartDate] = extractDate(adjustedBegin);
  agg.m[Scope.StartTime] = extractTimeOfDay(adjustedBegin);
  return agg;
}

TimeAggregate adjustEndToBegin(TimeAggregate agg) {
  DateTime begin = joinDateTime(agg.m[Scope.StartDate], agg.m[Scope.StartTime]);
  DateTime end = joinDateTime(agg.m[Scope.EndDate], agg.m[Scope.EndTime]);
  if (begin.isBefore(end)) {
    return agg;
  }
  DateTime adjustedEnd = begin.add(Duration(hours: 1));
  agg.m[Scope.EndDate] = extractDate(adjustedEnd);
  agg.m[Scope.EndTime] = extractTimeOfDay(adjustedEnd);
  return agg;
}