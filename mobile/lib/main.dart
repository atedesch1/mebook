import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mebook/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MebookApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}
