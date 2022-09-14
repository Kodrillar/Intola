import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/user_onboarding/data/repository/user_onboarding_repository.dart';
import 'package:intola/src/routing/route.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/loading_indicator.dart';

class IntolaApp extends ConsumerWidget {
  const IntolaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialScreen = ref.watch(getInitialScreenProvider);
    return MaterialApp(
      color: Colors.green,
      debugShowCheckedModeBanner: false,
      title: 'Intola',
      theme: ThemeData(
        primarySwatch: kDeepOrangeColor,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
      home: initialScreen.when(
        data: (screen) => screen,
        loading: () => const LoadingIndicator(),
        error: (error, stackTrace) => ErrorWidget(error),
      ),
      routes: AppRoute.routes,
    );
  }
}
