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
            elevation: 6,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Edit Event',
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
                    // controller: _contentController,
                    // onSubmitted: (_) => _submitData(),
                  ),
                  TimeRow(
                    iconColor: Colors.green,
                    timeText: 'Start Time',
                    selectTime: () => _selectTime(true),
                    time: startTime,
                  ),
                  TimeRow(
                    iconColor: Colors.redAccent,
                    timeText: 'End Time',
                    selectTime: () => _selectTime(false),
                    time: endTime,
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TimeRow extends StatelessWidget {
  final Color iconColor;
  final String timeText;
  final Function selectTime;
  final TimeOfDay time;

  TimeRow({this.iconColor, this.selectTime, this.timeText, this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Icon(
            Icons.access_time_filled_rounded,
            color: iconColor,
          ),
        ),
        Expanded(
          child: Text(
            timeText,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        TextButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(Size(100, 0)),
            elevation: MaterialStateProperty.all<double>(2),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: selectTime,
          child: Text('${time.format(context)}'),
        ),
      ],
    );
  }
}
