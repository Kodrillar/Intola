import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/profile/presentation/profile_screen_controller.dart';
import 'package:intola/src/routing/route.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/alert_dialog.dart';
import 'package:intola/src/widgets/async_value_display.dart';

import 'package:intola/src/widgets/buttons/custom_round_button.dart';

class ProfileBottomAppBar extends ConsumerWidget {
  const ProfileBottomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileScreenControllerProvider);
    ref.listen<AsyncValue>(profileScreenControllerProvider,
        (previousState, newState) {
      newState.showErrorAlertDialog(context);
    });
    return BottomAppBar(
      elevation: 0,
      child: SizedBox(
        height: 120,
        child: state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CustomRoundButton(
                      onTap: () {
                        CustomAlertDialog.showAlertDialog(
                          context: context,
                          title: "Not available!",
                          content: "coming soon...",
                        );
                      },
                      buttonText: "Update",
                      buttonColor: kDarkBlue,
                    ),
                  ),
                  Center(
                    child: CustomRoundButton(
                      onTap: () async {
                        final success = await ref
                            .read(profileScreenControllerProvider.notifier)
                            .signOut();

                        if (success) {
                          Navigator.pushNamedAndRemoveUntil(context,
                              RouteName.loginScreen.name, (route) => false);
                        }
                      },
                      buttonText: "Log out",
                      buttonColor: kDarkBlue,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
