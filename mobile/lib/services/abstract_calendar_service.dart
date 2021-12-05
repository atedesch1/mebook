import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';

abstract class AbstractCalendarService {
  Future<Events> getMonthEvents(DateTime chosenMonth);

  Future<Events> getDailyEvents(DateTime chosenDay);

  Future<void> updateEvent({
    @required Event event,
    String summary,
    EventDateTime start,
    EventDateTime end,
  });

  Future<void> createEvent({
    @required String summary,
    @required EventDateTime start,
    @required EventDateTime end,
  });

  Future<void> deleteEvent(String id);
}