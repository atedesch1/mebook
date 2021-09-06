import 'package:flutter/material.dart';

import 'package:mebook/widgets/mebook_logo.dart';

// TODO: Get the logo right and add a proper Splash Screen internally (Android and iOS).
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
