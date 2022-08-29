import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intola/src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(
    const IntolaApp(),
  );
}
