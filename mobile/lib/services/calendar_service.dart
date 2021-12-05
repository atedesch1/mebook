import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:mebook/widgets/schedule/calendar_utils.dart';
import 'package:mebook/services/abstract_calendar_service.dart';
import 'package:mebook/services/auth_service.dart';
import 'package:provider/src/provider.dart';

class CalendarService extends AbstractCalendarService {
  CalendarApi _api;

  CalendarService(BuildContext context) {
    _api = CalendarApi(context.read<AuthService>().client);
  }

  @override
  Future<Events> getMonthEvents(DateTime chosenMonth) async {
    var firstDayOfMonth = DateTime(chosenMonth.year, chosenMonth.month, 1);
    var lastDayOfMonth = DateTime(chosenMonth.year, chosenMonth.month + 1, 1)
        .subtract(Duration(seconds: 1));

    Events events = await _api.events
        .list('primary', timeMin: firstDayOfMonth, timeMax: lastDayOfMonth);
    events.items.map((e) => addTimeZone(e));
    return events;
  }

  @override
  Future<Events> getDailyEvents(DateTime chosenDay) async {
    var firstTimeOfDay = DateTime(
        chosenDay.year,
        chosenDay.month,
        chosenDay.day
    );
    var lastTimeOfDay = firstTimeOfDay.add(Duration(days: 1));

    Events events = await _api.events
        .list('primary', timeMin: firstTimeOfDay, timeMax: lastTimeOfDay);
    events.items.map((e) => addTimeZone(e));
    return events;
  }

  @override
  Future<void> updateEvent({
    @required Event event,
    String summary,
    EventDateTime start,
    EventDateTime end,
  }) {
    event.summary = summary;
    event.start = start;
    event.end = end;
    event = removeTimeZone(event);

    return _api.events.update(event, 'primary', event.id);
  }

  @override
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
    event = removeTimeZone(event);

    return _api.events.insert(event, 'primary');
  }

  @override
  Future<void> deleteEvent(String id) {
    return _api.events.delete('primary', id);
  }
}
