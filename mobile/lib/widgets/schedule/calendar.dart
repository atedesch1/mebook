import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

final today = DateTime.now();
final calendarFirstDay = DateTime(today.year, today.month - 2, 1);
final calendarLastDay = DateTime(today.year, today.month + 6, 0);

class Calendar extends StatefulWidget {
  final Function updateMonth;
  Calendar({@required this.updateMonth});

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = today;
  DateTime _selectedDay;

  @override
  Widget build(BuildContext context) {
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
        selectedBuilder: (context, date, events) => Container(
            margin: const EdgeInsets.all(6.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                shape: BoxShape.circle),
            child: Text(date.day.toString(),
                style: TextStyle(color: Colors.white))),
        todayBuilder: (context, date, events) => Container(
            margin: const EdgeInsets.all(6.0),
            alignment: Alignment.center,
            decoration:
                BoxDecoration(color: Colors.cyan[100], shape: BoxShape.circle),
            child: Text(date.day.toString(),
                style: TextStyle(color: Colors.white))),
      ),
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          // Call `setState()` when updating the selected day
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        }
      },
      onPageChanged: (focusedDay) {
        // No need to call `setState()` here
        _focusedDay = focusedDay;
        widget.updateMonth(focusedDay);
      },
    );
  }
}
