import 'package:flutter/material.dart';
import 'package:mebook/services/calendar_service.dart';
import 'package:mebook/widgets/misc/popup_rect_tween.dart';
import 'package:googleapis/calendar/v3.dart' as googleApis;
import 'package:mebook/widgets/schedule/date_row.dart';
import 'package:mebook/widgets/schedule/time_row.dart';

const String _CalendarEventPopUp = 'calendar-event-pop-up';

class EditEventCard extends StatefulWidget {
  final CalendarService service;
  final googleApis.Event event;
  final Function refreshCallBack;

  EditEventCard({
    @required this.service,
    @required this.refreshCallBack,
    this.event,
  });

  @override
  _EditEventCardState createState() => _EditEventCardState();
}

class _EditEventCardState extends State<EditEventCard> {
  final _summaryController = TextEditingController();
  DateTime startDate;
  DateTime endDate;
  TimeOfDay startTime;
  TimeOfDay endTime;

  @override
  void initState() {
    if (widget.event != null) {
      _summaryController.text = widget.event.summary;

      startDate = widget.event.start.dateTime;
      endDate = widget.event.end.dateTime;

      startTime = TimeOfDay.fromDateTime(widget.event.start.dateTime);
      endTime = TimeOfDay.fromDateTime(widget.event.end.dateTime);
    } else {
      startDate = DateTime.now();
      endDate = DateTime.now();

      startTime = TimeOfDay(hour: 0, minute: 0);
      endTime = TimeOfDay(hour: 0, minute: 0);
    }
    super.initState();
  }

  void _selectTime(bool isStartTime) async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: isStartTime ? startTime : endTime,
    );

    if (newTime != null) {
      setState(() {
        if (isStartTime)
          startTime = newTime;
        else {
          endTime = newTime;
          if (constructDateTime(startDate, startTime)
                  .compareTo(constructDateTime(endDate, endTime)) >
              0) startTime = endTime;
        }
      });
    }
  }

  DateTime constructDateTime(DateTime date, TimeOfDay timeOfDay) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      timeOfDay.hour + DateTime.now().timeZoneOffset.inHours,
      timeOfDay.minute,
    );
  }

  void _submitData() async {
    final enteredSummary = _summaryController.text;

    if (enteredSummary.isEmpty) {
      return;
    }

    final start = googleApis.EventDateTime(
        dateTime: constructDateTime(startDate, startTime));
    final end =
        googleApis.EventDateTime(dateTime: constructDateTime(endDate, endTime));

    if (widget.event == null)
      await widget.service
          .createEvent(summary: enteredSummary, start: start, end: end);
    else
      await widget.service.updateEvent(
        event: widget.event,
        summary: enteredSummary,
        start: start,
        end: end,
      );

    widget.refreshCallBack();
    Navigator.of(context).pop();
  }

  void _presentDatePicker(bool isStartDate) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.parse("2000-01-01 00:00:00Z"),
      lastDate: DateTime.parse("3000-01-01 00:00:00Z"),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        if (isStartDate)
          startDate = pickedDate;
        else
          endDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Hero(
          tag: _CalendarEventPopUp,
          createRectTween: (begin, end) {
            return PopUpRectTween(begin: begin, end: end);
          },
          child: Material(
            elevation: 6,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          widget.event == null ? 'Add Event' : 'Edit Event',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        )),
                        IconButton(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(0),
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(Icons.close),
                        ),
                      ],
                    ),
                    TextField(
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        filled: false,
                        contentPadding: EdgeInsets.all(0),
                        hintText: 'Event Name',
                      ),
                      controller: _summaryController,
                      onSubmitted: (_) => _submitData(),
                    ),
                    DateRow(
                      iconColor: Colors.green,
                      dateText: 'Start Day',
                      selectDate: () => _presentDatePicker(true),
                      date: startDate,
                    ),
                    TimeRow(
                      iconColor: Colors.green,
                      timeText: 'Start Time',
                      selectTime: () => _selectTime(true),
                      time: startTime,
                    ),
                    DateRow(
                      iconColor: Colors.red,
                      dateText: 'End Day',
                      selectDate: () => _presentDatePicker(false),
                      date: endDate,
                    ),
                    TimeRow(
                      iconColor: Colors.redAccent,
                      timeText: 'End Time',
                      selectTime: () => _selectTime(false),
                      time: endTime,
                    ),
                    IconButton(
                      onPressed: _submitData,
                      icon: Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
