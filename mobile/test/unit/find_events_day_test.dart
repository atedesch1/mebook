import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:mebook/models/event_model.dart';
import 'package:mebook/widgets/schedule/calendar_utils.dart';

void main() {
  test('Should find the days that has events', () {
    final event_1 = Event(
      id: 'mock-id-1',
      title: 'Evento 1',
      startTime: DateTime(2021, 12, 6, 15, 30), // 06/12/2021 15h30min,
      endTime: DateTime(2021, 12, 6, 18, 30), // 06/12/2021 18h30min
    );

    final event_2 = Event(
      id: 'mock-id-2',
      title: 'Evento 2',
      startTime: DateTime(2021, 12, 8, 10, 30), // 08/12/2021 10h30min,
      endTime: DateTime(2021, 12, 8, 13, 00), // 08/12/2021 13h00min
    );

    final event_3 = Event(
      id: 'mock-id-3',
      title: 'Evento 3',
      startTime: DateTime(2021, 12, 9, 21, 00), // 09/12/2021 10h30min,
      endTime: DateTime(2021, 12, 9, 23, 15), // 09/12/2021 13h00min
    );

    final list_events = [event_1, event_2, event_3];

    Map<int, bool> map1 = {
      event_1.startTime.day: true,
      event_2.startTime.day: true,
      event_3.startTime.day: true,
    };

    Map<int, bool> map2 = findDays(list_events);

    expect(mapEquals(map1, map2), true);
  });
}
