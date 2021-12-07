import 'package:flutter/material.dart';
import 'package:mebook/models/event_model.dart';
import 'package:mebook/services/abstract_calendar_service.dart';
import 'package:mebook/services/auth_service.dart';
import 'package:mebook/services/firebase_calendar_service.dart';
import 'package:mebook/services/google_calendar_service.dart';
import 'package:mebook/widgets/schedule/day_container.dart';
import 'package:provider/src/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:mebook/widgets/schedule/calendar_utils.dart';

final calendarFirstDay = DateTime(1950, 1, 1);
final calendarLastDay = DateTime(2150, 1, 1);

class Calendar extends StatefulWidget {
  final Function updateMonth;
  final Function updateDate;
  final String selectedCalendarId;

  Calendar({
    @required this.updateMonth,
    @required this.updateDate,
    @required this.selectedCalendarId,
  });

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    AbstractCalendarService calendarService;
    if (context.read<AuthService>().getAuthenticationMethod ==
        Authentication.Google) {
      calendarService = GoogleCalendarService(context);
    } else {
      calendarService = FirebaseCalendarService(context);
    }

    return FutureBuilder<List<Event>>(
        future: calendarService.getMonthEvents(
          calendarId: widget.selectedCalendarId,
          chosenMonth: _focusedDay,
        ),
        builder: (context, snapshot) {
          Map<int, bool> dayHasEvent = {};
          if (snapshot.hasData) {
            List<Event> events = snapshot.data;
            dayHasEvent = findDays(events);
          }
          return TableCalendar(
            firstDay: calendarFirstDay,
            lastDay: calendarLastDay,
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              // Use `selectedDayPredicate` to determine which day is currently selected.
              // If this returns true, then `day` will be marked as selected.

              // Using `isSameDay` is recommended to disregard
              // the time-part of compared DateTime objects.
              return isSameDay(_selectedDay, day);
            },
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, date, events) => DayContainer(
                hasEvents: snapshot.hasData
                    ? dayHasEvent.containsKey(date.day)
                    : false,
                textColor: Colors.black,
                content: date.day.toString(),
              ),
              selectedBuilder: (context, date, events) => DayContainer(
                hasEvents: snapshot.hasData
                    ? dayHasEvent.containsKey(date.day)
                    : false,
                color: Colors.deepPurpleAccent,
                textColor: Colors.white,
                content: date.day.toString(),
              ),
              todayBuilder: (context, date, events) => DayContainer(
                hasEvents: snapshot.hasData
                    ? dayHasEvent.containsKey(date.day)
                    : false,
                textColor: Colors.white,
                color: Colors.deepPurpleAccent[100],
                content: date.day.toString(),
              ),
            ),
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  widget.updateDate(selectedDay);
                });
              }
            },
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _focusedDay = focusedDay;
              widget.updateMonth(focusedDay);
            },
          );
        });
  }
}
