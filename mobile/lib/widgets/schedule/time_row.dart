import 'package:flutter/material.dart';

class TimeRow extends StatelessWidget {
  final Color iconColor;
  final String timeText;
  final Function selectTime;
  final TimeOfDay time;
  final String keyPrefix;

  TimeRow({this.keyPrefix, this.iconColor, this.selectTime, this.timeText, this.time});

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
          key: ValueKey('${keyPrefix}Button'),
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
