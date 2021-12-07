import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SimpleCountStatistic extends StatelessWidget {
  final int count;
  final String name;

  SimpleCountStatistic({@required this.name, @required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            count.toString(),
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
