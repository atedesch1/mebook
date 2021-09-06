import 'package:flutter/material.dart';

class MebookLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(deviceWidth * 0.6),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black, width: 4),
        ),
        width: deviceWidth * 0.6,
        height: deviceWidth * 0.6,
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
