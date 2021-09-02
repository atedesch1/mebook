import 'package:flutter/material.dart';

import 'package:mebook/widgets/mebook_logo.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MebookLogo(),
      ),
    );
  }
}
