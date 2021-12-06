import 'package:flutter/material.dart';

import 'package:mebook/models/event_model.dart';

abstract class AbstractCalendarService {
  Future<Map<String, Map<String, dynamic>>> getCalendars();

  Future<List<Event>> getMonthEvents(DateTime chosenMonth);

  Future<List<Event>> getDailyEvents(DateTime chosenDay);

  Future<void> updateEvent({
    @required Event event,
    String title,
    DateTime start,
    DateTime end,
  });

  Future<void> createEvent({
    @required String title,
    @required DateTime start,
    @required DateTime end,
  });

  Future<void> deleteEvent(String id);
}
