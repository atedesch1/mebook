import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart' as googleCalendar;
import 'package:provider/src/provider.dart';

import 'package:mebook/widgets/schedule/calendar_utils.dart';
import 'package:mebook/services/abstract_calendar_service.dart';
import 'package:mebook/services/auth_service.dart';
import 'package:mebook/models/event_model.dart';

class GoogleCalendarService extends AbstractCalendarService {
  googleCalendar.CalendarApi _api;

  GoogleCalendarService(BuildContext context) {
    _api = googleCalendar.CalendarApi(context.read<AuthService>().client);
  }

  @override
  Future<Map<String, Map<String, dynamic>>> getCalendars() async {
    googleCalendar.CalendarList calendarList = await _api.calendarList.list();
    return {
      for (var calendar in calendarList.items)
        calendar.id: {
          'name': calendar.summary,
          'isPrimary': calendar.primary ?? false
        }
    };
  }

  @override
  Future<List<Event>> getMonthEvents(DateTime chosenMonth) async {
    var firstDayOfMonth = DateTime(chosenMonth.year, chosenMonth.month, 1);
    var lastDayOfMonth = DateTime(chosenMonth.year, chosenMonth.month + 1, 1)
        .subtract(Duration(seconds: 1));

    googleCalendar.Events events = await _api.events
        .list('primary', timeMin: firstDayOfMonth, timeMax: lastDayOfMonth);
    List<Event> eventModels =
        events.items.map((e) => Event.fromGoogle(addTimeZone(e))).toList();
    return eventModels;
  }

  @override
  Future<List<Event>> getDailyEvents(DateTime chosenDay) async {
    var firstTimeOfDay =
        DateTime(chosenDay.year, chosenDay.month, chosenDay.day);
    var lastTimeOfDay = firstTimeOfDay.add(Duration(days: 1));

    googleCalendar.Events events = await _api.events
        .list('primary', timeMin: firstTimeOfDay, timeMax: lastTimeOfDay);
    List<Event> eventModels =
        events.items.map((e) => Event.fromGoogle(addTimeZone(e))).toList();
    return eventModels;
  }

  @override
  Future<void> updateEvent({
    @required Event event,
    String title,
    DateTime start,
    DateTime end,
  }) {
    googleCalendar.Event googleEvent = googleCalendar.Event(
      summary: title,
      start: googleCalendar.EventDateTime(dateTime: start),
      end: googleCalendar.EventDateTime(dateTime: end),
    );
    googleEvent = removeTimeZone(googleEvent);

    return _api.events.update(googleEvent, 'primary', event.id);
  }

  @override
  Future<void> createEvent({
    @required String title,
    @required DateTime start,
    @required DateTime end,
  }) {
    googleCalendar.Event event = googleCalendar.Event(
      summary: title,
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
