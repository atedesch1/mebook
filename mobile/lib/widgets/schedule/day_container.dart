import 'package:flutter/material.dart';

class DayContainer extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String content;
  final bool hasEvents;

  DayContainer({
    this.color,
    this.textColor,
    @required this.content,
    this.hasEvents,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            margin: const EdgeInsets.all(6.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: color ?? Theme.of(context).primaryColor,
                shape: BoxShape.circle),
            child: Text(content,
                style: TextStyle(color: textColor ?? Colors.grey))),
        if (hasEvents ?? false)
          Container(
            margin: EdgeInsets.only(top: 20),
            width: 3.5,
            decoration: BoxDecoration(
              color: Colors.purpleAccent,
              shape: BoxShape.circle,
            ),
          )
      ],
    );
  }
}
