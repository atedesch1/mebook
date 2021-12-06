import 'package:flutter/material.dart';

import 'package:mebook/services/abstract_calendar_service.dart';
import 'package:mebook/widgets/misc/popup_rect_tween.dart';
import 'package:mebook/widgets/schedule/date_row.dart';
import 'package:mebook/widgets/schedule/time_row.dart';
import 'package:mebook/widgets/schedule/calendar_utils.dart';
import 'package:mebook/models/event_model.dart';

const String _CalendarEventPopUp = 'calendar-event-pop-up';

class EditEventCard extends StatefulWidget {
  final AbstractCalendarService service;
  final Event event;
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
  TimeAggregate timeAgg;

  @override
  void initState() {
    if (widget.event != null) {
      _summaryController.text = widget.event.title;

      timeAgg = TimeAggregate(
        extractDate(widget.event.startTime),
        extractTimeOfDay(widget.event.startTime),
        extractDate(widget.event.endTime),
        extractTimeOfDay(widget.event.endTime),
      );
    } else {
      timeAgg = TimeAggregate(
        extractDate(DateTime.now()),
        TimeOfDay(hour: 0, minute: 0),
        extractDate(widget.event.endTime),
        TimeOfDay(hour: 0, minute: 0),
      );
    }
    super.initState();
  }

  void _selectStartTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: timeAgg.startTime,
    );

    if (newTime != null) {
      setState(() {
        timeAgg.startTime = newTime;
        timeAgg = adjustEndToBegin(timeAgg);
      });
    }
  }

  void _selectEndTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: timeAgg.endTime,
    );

    if (newTime != null) {
      setState(() {
        timeAgg.endTime = newTime;
        timeAgg = adjustBeginToEnd(timeAgg);
      });
    }
  }

  void _selectStartDate() async {
    final DateTime newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.parse("2000-01-01 00:00:00Z"),
      lastDate: DateTime.parse("3000-01-01 00:00:00Z"),
    );

    if (newDate == null) {
      return;
    }
    setState(() {
      timeAgg.startDate = newDate;
      timeAgg = adjustEndToBegin(timeAgg);
    });
  }

  void _selectEndDate() async {
    final DateTime newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.parse("2000-01-01 00:00:00Z"),
      lastDate: DateTime.parse("3000-01-01 00:00:00Z"),
    );

    if (newDate == null) {
      return;
    }
    setState(() {
      timeAgg.endDate = newDate;
      timeAgg = adjustBeginToEnd(timeAgg);
    });
  }

  void _submitData() async {
    final enteredSummary = _summaryController.text;

    if (enteredSummary.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Title missing!')),
      );
      return;
    }

    if (widget.event == null)
      await widget.service.createEvent(
        title: enteredSummary,
        start: joinDateTime(timeAgg.startDate, timeAgg.startTime),
        end: joinDateTime(timeAgg.endDate, timeAgg.endTime),
      );
    else
      await widget.service.updateEvent(
        event: widget.event,
        title: enteredSummary,
        start: joinDateTime(timeAgg.startDate, timeAgg.startTime),
        end: joinDateTime(timeAgg.endDate, timeAgg.endTime),
      );

    widget.refreshCallBack();
    Navigator.of(context).pop();
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
                      onSubmitted: (_) => TextInputAction.previous,
                    ),
                    DateRow(
                      iconColor: Colors.green,
                      dateText: 'Start Day',
                      selectDate: () => _selectStartDate(),
                      date: timeAgg.startDate,
                    ),
                    TimeRow(
                      iconColor: Colors.green,
                      timeText: 'Start Time',
                      selectTime: () => _selectStartTime(),
                      time: timeAgg.startTime,
                    ),
                    DateRow(
                      iconColor: Colors.red,
                      dateText: 'End Day',
                      selectDate: () => _selectEndDate(),
                      date: timeAgg.endDate,
                    ),
                    TimeRow(
                      iconColor: Colors.redAccent,
                      timeText: 'End Time',
                      selectTime: () => _selectEndTime(),
                      time: timeAgg.endTime,
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
