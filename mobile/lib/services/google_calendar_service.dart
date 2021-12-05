import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart' as googleCalendar;
import 'package:mebook/widgets/schedule/calendar_utils.dart';
import 'package:mebook/services/abstract_calendar_service.dart';
import 'package:mebook/services/auth_service.dart';
import 'package:provider/src/provider.dart';

class GoogleCalendarService extends AbstractCalendarService {
  googleCalendar.CalendarApi _api;

  GoogleCalendarService(BuildContext context) {
    _api = googleCalendar.CalendarApi(context.read<AuthService>().client);
  }

  @override
  Future<googleCalendar.Events> getMonthEvents(DateTime chosenMonth) async {
    var firstDayOfMonth = DateTime(chosenMonth.year, chosenMonth.month, 1);
    var lastDayOfMonth = DateTime(chosenMonth.year, chosenMonth.month + 1, 1)
        .subtract(Duration(seconds: 1));

    googleCalendar.Events events = await _api.events
        .list('primary', timeMin: firstDayOfMonth, timeMax: lastDayOfMonth);
    events.items.map((e) => addTimeZone(e));
    return events;
  }

  @override
  Future<googleCalendar.Events> getDailyEvents(DateTime chosenDay) async {
    var firstTimeOfDay = DateTime(
        chosenDay.year,
        chosenDay.month,
        chosenDay.day
    );
    var lastTimeOfDay = firstTimeOfDay.add(Duration(days: 1));

    googleCalendar.Events events = await _api.events
        .list('primary', timeMin: firstTimeOfDay, timeMax: lastTimeOfDay);
    events.items.map((e) => addTimeZone(e));
    return events;
  }

  @override
  Future<void> updateEvent({
    @required googleCalendar.Event event,
    String summary,
    DateTime start,
    DateTime end,
  }) {
    event.summary = summary;
    event.start = googleCalendar.EventDateTime(dateTime: start);
    event.end = googleCalendar.EventDateTime(dateTime: end);
    event = removeTimeZone(event);

    return _api.events.update(event, 'primary', event.id);
  }

  @override
  Future<void> createEvent({
    @required String summary,
    @required DateTime start,
    @required DateTime end,
  }) {
    googleCalendar.Event event = googleCalendar.Event(
      summary: summary,
      start: googleCalendar.EventDateTime(dateTime: start),
      end: googleCalendar.EventDateTime(dateTime: end),
    );
    event = removeTimeZone(event);

    return _api.events.insert(event, 'primary');
  }

  @override
  Future<void> deleteEvent(String id) {
    return _api.events.delete('primary', id);
  }
}
