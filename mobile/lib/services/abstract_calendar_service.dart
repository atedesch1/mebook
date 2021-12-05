import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart' as googleCalendar;

abstract class AbstractCalendarService {
  Future<googleCalendar.Events> getMonthEvents(DateTime chosenMonth);

  Future<googleCalendar.Events> getDailyEvents(DateTime chosenDay);

  Future<void> updateEvent({
    @required googleCalendar.Event event,
    String summary,
    googleCalendar.EventDateTime start,
    googleCalendar.EventDateTime end,
  });

  Future<void> createEvent({
    @required String summary,
    @required googleCalendar.EventDateTime start,
    @required googleCalendar.EventDateTime end,
  });

  Future<void> deleteEvent(String id);
}