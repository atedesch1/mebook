import 'package:flutter/material.dart';

class MebookLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 4),
      ),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          padding: EdgeInsets.only(bottom: 2),
          child: Text(
            'me',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
