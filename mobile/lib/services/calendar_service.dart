import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:mebook/services/auth_service.dart';
import 'package:provider/src/provider.dart';

class CalendarService {
  CalendarApi _api;

  CalendarService(BuildContext context) {
    _api = CalendarApi(context.read<AuthService>().client);
  }

  Stream<Events> get getEvents => _api.events.list('primary').asStream();

  Stream<Events> getEventsForMonth(DateTime chosenMonth) {
    var firstDayOfMonth = DateTime(chosenMonth.year, chosenMonth.month, 1);
    var lastDayOfMonth = DateTime(chosenMonth.year, chosenMonth.month + 1, 1)
        .subtract(Duration(seconds: 1));

    return _api.events
        .list('primary', timeMin: firstDayOfMonth, timeMax: lastDayOfMonth)
        .asStream();
  }

  Future<Events> getMonthEvents(DateTime chosenMonth) {
    var firstDayOfMonth = DateTime(chosenMonth.year, chosenMonth.month, 1);
    var lastDayOfMonth = DateTime(chosenMonth.year, chosenMonth.month + 1, 1)
        .subtract(Duration(seconds: 1));

    return _api.events
        .list('primary', timeMin: firstDayOfMonth, timeMax: lastDayOfMonth);
  }

  Future<Events> getDailyEvents(DateTime chosenDay) {
    var firstTimeOfDay = DateTime(
        chosenDay.year,
        chosenDay.month,
        chosenDay.day
    );
    var lastTimeOfDay = firstTimeOfDay.add(Duration(days: 1));

    return _api.events
        .list('primary', timeMin: firstTimeOfDay, timeMax: lastTimeOfDay);
  }

  Future<void> updateEvent({
    @required Event event,
    String summary,
    EventDateTime start,
    EventDateTime end,
  }) {
    event.summary = summary;
    event.start = start;
    event.end = end;

    return _api.events.update(event, 'primary', event.id);
  }

  Future<void> createEvent({
    @required String summary,
    @required EventDateTime start,
    @required EventDateTime end,
  }) {
    Event event = Event(
      summary: summary,
      start: start,
      end: end,
    );
    return _api.events.insert(event, 'primary');
  }

  Future<void> deleteEvent(String id) {
    return _api.events.delete('primary', id);
  }
}
