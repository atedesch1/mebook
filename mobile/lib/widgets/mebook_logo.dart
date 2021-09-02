import 'package:flutter/material.dart';

class MebookLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black, width: 4),
        ),
        width: 200,
        height: 200,
        child: Center(
          child: Stack(children: [
            Text(
              'me',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 103,
                fontWeight: FontWeight.bold,
                color: Colors.white38,
              ),
            ),
            Text(
              'me',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 100,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
