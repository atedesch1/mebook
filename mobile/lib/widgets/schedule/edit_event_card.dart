import 'package:flutter/material.dart';

import 'package:mebook/services/abstract_calendar_service.dart';
import 'package:mebook/widgets/misc/popup_rect_tween.dart';
import 'package:mebook/widgets/schedule/date_row.dart';
import 'package:mebook/widgets/schedule/time_row.dart';
import 'package:mebook/widgets/schedule/calendar_utils.dart';
import 'package:mebook/models/event_model.dart';

const String _CalendarEventPopUp = 'calendar-event-pop-up';

Future<TimeOfDay> _showTimePicker(BuildContext context, TimeOfDay t) {
  return showTimePicker(context: context, initialTime: t);
}

Future<DateTime> _showDatePicker(BuildContext context, DateTime d) {
  return showDatePicker(
      context: context, initialDate: d, firstDate: past, lastDate: future);
}

class EditEventCard extends StatefulWidget {
  final AbstractCalendarService service;
  final Event event;
  final String selectedCalendarId;
  final Function refreshCallBack;
  final Map<Scope, Function> adjuster = <Scope, Function>{
    Scope.StartDate: adjustEndToBegin,
    Scope.StartTime: adjustEndToBegin,
    Scope.EndDate: adjustBeginToEnd,
    Scope.EndTime: adjustBeginToEnd,
  };
  final Map<Scope, Function> picker = <Scope, Function>{
    Scope.StartDate: _showDatePicker,
    Scope.StartTime: _showTimePicker,
    Scope.EndDate: _showDatePicker,
    Scope.EndTime: _showTimePicker,
  };

  EditEventCard({
    @required this.selectedCalendarId,
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
        extractDate(DateTime.now()),
        TimeOfDay(hour: 0, minute: 0),
      );
    }
    super.initState();
  }

  void _selectScopeValue(Scope s) async {
    final dynamic newScope = await widget.picker[s](context, timeAgg.m[s]);
    if (newScope != null) {
      setState(() {
        timeAgg.m[s] = newScope;
        timeAgg = widget.adjuster[s](timeAgg);
      });
    }
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
        calendarId: widget.selectedCalendarId,
        title: enteredSummary,
        start: joinDateTime(
            timeAgg.m[Scope.StartDate], timeAgg.m[Scope.StartTime]),
        end: joinDateTime(timeAgg.m[Scope.EndDate], timeAgg.m[Scope.EndTime]),
      );
    else
      await widget.service.updateEvent(
        calendarId: widget.selectedCalendarId,
        event: widget.event,
        title: enteredSummary,
        start: joinDateTime(
            timeAgg.m[Scope.StartDate], timeAgg.m[Scope.StartTime]),
        end: joinDateTime(timeAgg.m[Scope.EndDate], timeAgg.m[Scope.EndTime]),
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
                      selectDate: () => _selectScopeValue(Scope.StartDate),
                      date: timeAgg.m[Scope.StartDate],
                    ),
                    TimeRow(
                      iconColor: Colors.green,
                      timeText: 'Start Time',
                      selectTime: () => _selectScopeValue(Scope.StartTime),
                      time: timeAgg.m[Scope.StartTime],
                    ),
                    DateRow(
                      iconColor: Colors.red,
                      dateText: 'End Day',
                      selectDate: () => _selectScopeValue(Scope.EndDate),
                      date: timeAgg.m[Scope.EndDate],
                    ),
                    TimeRow(
                      iconColor: Colors.redAccent,
                      timeText: 'End Time',
                      selectTime: () => _selectScopeValue(Scope.EndTime),
                      time: timeAgg.m[Scope.EndTime],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: _submitData,
                          icon: Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                        ),
                        if (widget.event != null)
                          IconButton(
                            onPressed: () async {
                              await widget.service.deleteEvent(
                                calendarId: widget.selectedCalendarId,
                                eventId: widget.event.id,
                              );
                              widget.refreshCallBack();
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                      ],
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
