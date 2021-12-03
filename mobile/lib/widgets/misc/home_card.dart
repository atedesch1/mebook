import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final List<Widget> widgets;
  final double height;
  final String title;
  final Widget header;

  HomeCard({
    this.height,
    this.title,
    this.header,
    this.widgets,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(2, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: Colors.black12),
              ),
            ),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(10),
            child: header != null
                ? header
                : Text(
                    title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
          ),
          ...widgets,
        ],
      ),
    );
  }
}
