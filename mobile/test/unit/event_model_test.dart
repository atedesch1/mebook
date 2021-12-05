import 'package:flutter_test/flutter_test.dart';
import 'package:mebook/models/event_model.dart';

void main() {
  test('Event model should support UTC parse', () {
    String eventId = "0";
    String summary = "title";

    DateTime startTime = DateTime.parse("2021-11-11T10:40:00+00:00");
    String startTimeString = startTime.toIso8601String().replaceAll('Z', '');
    startTime = DateTime.parse(startTimeString);

    DateTime endTime = DateTime.parse("2021-11-11T11:50:00+00:00");
    String endTimeString = endTime.toIso8601String().replaceAll('Z', '');
    endTime = DateTime.parse(endTimeString);

    bool notify = false;

    Event calendarEvent = Event(
        id: eventId,
        title: summary,
        startTime: startTime,
        endTime: endTime);

    expect(calendarEvent.id, "0");
    expect(calendarEvent.title, "title");
    expect(calendarEvent.startTime, DateTime(2021, 11, 11, 10, 40));
    expect(calendarEvent.endTime, DateTime(2021, 11, 11, 11, 50));
  });
}
