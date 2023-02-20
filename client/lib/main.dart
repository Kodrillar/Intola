import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  final container = ProviderContainer();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const IntolaApp(),
    ),
  );
}
