import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRow extends StatelessWidget {
  final Color iconColor;
  final String dateText;
  final Function selectDate;
  final DateTime date;

  DateRow({this.iconColor, this.selectDate, this.dateText, this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Icon(
            Icons.today,
            color: iconColor,
          ),
        ),
        Expanded(
          child: Text(
            dateText,
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
          onPressed: selectDate,
          child: Text(DateFormat.yMd().format(date)),
        ),
      ],
    );
  }
}
