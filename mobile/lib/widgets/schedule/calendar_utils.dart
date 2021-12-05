import 'package:googleapis/calendar/v3.dart';

Event addTimeZone(Event e) {
  e.start.dateTime = e.start.dateTime.toLocal();
  e.end.dateTime = e.end.dateTime.toLocal();
  return e;
}

Event removeTimeZone(Event e) {
  e.start.dateTime = e.start.dateTime.toUtc();
  e.end.dateTime = e.end.dateTime.toUtc();
  return e;
}