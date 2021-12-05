import 'package:googleapis/calendar/v3.dart' as googleCalendar;

googleCalendar.Event addTimeZone(googleCalendar.Event e) {
  e.start.dateTime = e.start.dateTime.toLocal();
  e.end.dateTime = e.end.dateTime.toLocal();
  return e;
}

googleCalendar.Event removeTimeZone(googleCalendar.Event e) {
  e.start.dateTime = e.start.dateTime.toUtc();
  e.end.dateTime = e.end.dateTime.toUtc();
  return e;
}