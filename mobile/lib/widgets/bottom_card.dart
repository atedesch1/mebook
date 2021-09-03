import 'package:flutter/material.dart';

class BottomCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  BottomCard({this.child, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      padding: EdgeInsets.only(
        top: 50,
        bottom: 50,
        left: 25,
        right: 25,
      ),
      child: child,
    );
  }
}
