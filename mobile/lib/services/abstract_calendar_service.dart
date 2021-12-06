import 'package:flutter/material.dart';

import 'package:mebook/models/event_model.dart';

abstract class AbstractCalendarService {
  Future<Map<String, Map<String, dynamic>>> getCalendars();

  Future<List<Event>> getMonthEvents({
    String calendarId = 'primary',
    @required DateTime chosenMonth,
  });

  Future<List<Event>> getDailyEvents({
    String calendarId = 'primary',
    @required DateTime chosenDay,
  });

  Future<void> updateEvent({
    String calendarId = 'primary',
    @required Event event,
    String title,
    DateTime start,
    DateTime end,
  });

  Future<void> createEvent({
    String calendarId = 'primary',
    @required String title,
    @required DateTime start,
    @required DateTime end,
  });

  Future<void> deleteEvent({
    String calendarId = 'primary',
    @required String eventId,
  });
}
