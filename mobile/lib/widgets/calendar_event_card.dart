import 'package:flutter/material.dart';
import 'package:mebook/widgets/popup_rect_tween.dart';

const String _CalendarEventPopUp = 'calendar-event-pop-up';

class CalendarEventCard extends StatefulWidget {
  @override
  _CalendarEventCardState createState() => _CalendarEventCardState();
}

class _CalendarEventCardState extends State<CalendarEventCard> {
  TimeOfDay startTime = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay endTime = TimeOfDay(hour: 0, minute: 0);

  void _selectTime(bool isStartTime) async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: isStartTime ? startTime : endTime,
    );

    if (newTime != null) {
      setState(() {
        if (isStartTime)
          startTime = newTime;
        else
          endTime = newTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _CalendarEventPopUp,
          createRectTween: (begin, end) {
            return PopUpRectTween(begin: begin, end: end);
          },
          child: Material(
            color: Theme.of(context).backgroundColor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      maxLines: null,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        filled: false,
                        contentPadding: EdgeInsets.all(15),
                        hintText: 'Event',
                      ),
                      // controller: _contentController,
                      // onSubmitted: (_) => _submitData(),
                    ),
                    IconButton(
                        onPressed: () => _selectTime(true),
                        icon: Icon(Icons.timer)),
                    IconButton(
                        onPressed: () => _selectTime(false),
                        icon: Icon(Icons.timer)),
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
