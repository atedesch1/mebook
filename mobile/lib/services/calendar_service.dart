import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:mebook/models/event_model.dart';
import 'package:mebook/services/auth_service.dart';
import 'package:provider/src/provider.dart';

class CalendarService {
  CalendarApi _api;

  CalendarService(BuildContext context) {
    _api = CalendarApi(context.read<AuthService>().client);
  }

  Stream<Events> get getEvents => _api.events.list('primary').asStream();

  Stream<Events> getEventsForMonth(DateTime chosenDate) {
    var firstDayOfMonth = new DateTime(chosenDate.year, chosenDate.month, 1);
    var lastDayOfMonth = DateTime(chosenDate.year, chosenDate.month + 1, 1)
        .subtract(Duration(seconds: 1));

    return _api.events
        .list('primary', timeMin: firstDayOfMonth, timeMax: lastDayOfMonth)
        .asStream();
  }

  Future<Events> getMonthEvents(DateTime chosenDate) {
    var firstDayOfMonth = new DateTime(chosenDate.year, chosenDate.month, 1);
    var lastDayOfMonth = DateTime(chosenDate.year, chosenDate.month + 1, 1)
        .subtract(Duration(seconds: 1));

    return _api.events
        .list('primary', timeMin: firstDayOfMonth, timeMax: lastDayOfMonth);
  }
}
