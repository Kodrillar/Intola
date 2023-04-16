import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/profile/presentation/profile_app_bar.dart';
import 'package:intola/src/features/profile/presentation/profile_bottom_app_bar.dart';
import 'package:intola/src/features/profile/presentation/profile_screen_controller.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/async_value_display.dart';
import 'package:intola/src/widgets/error_display.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
        profileScreenControllerProvider.select(
            (state) => state.signOutAsyncValue), (previousState, newState) {
      newState.showErrorAlertDialog(context);
    });
    final state = ref.watch(profileScreenControllerProvider);
    return Scaffold(
      appBar: const ProfileAppBar(),
      bottomNavigationBar: const ProfileBottomAppBar(),
      body: state.profileAsyncValue.when(
        data: (data) => Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Icon(
                  Icons.account_circle,
                  size: 250,
                  color: kDarkBlue,
                ),
                Text(
                  data.fullname,
                  style: kProductNameStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  data.email,
                  style: kProductDetailStyle.copyWith(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (error, stackTrace) => ErrorDisplayWidget(
          error: error,
          onRetry: () => ref
              .read(profileScreenControllerProvider.notifier)
              .updateOnReload(),
        ),
      ),
    );
  }
}
