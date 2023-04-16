import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/profile/presentation/account_deletion_button.dart';
import 'package:intola/src/features/profile/presentation/profile_screen_controller.dart';
import 'package:intola/src/routing/route.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/alert_dialog.dart';

import 'package:intola/src/widgets/buttons/custom_round_button.dart';

class ProfileBottomAppBar extends ConsumerWidget {
  const ProfileBottomAppBar({Key? key}) : super(key: key);

  Future<void> _showSignOutConfirmationAlert({
    required BuildContext context,
    required Future<void> Function() onSignOutConfirmed,
  }) async {
    final bool shouldSignOut =
        await CustomAlertDialog.showConfirmationAlertDialog(
      context: context,
      title: "Log Out",
      content: "Are you sure you want to Log out?",
    );

    if (shouldSignOut) {
      await onSignOutConfirmed();
    }
  }

  Future<void> _showAccountDeletionConfirmation({
    required BuildContext context,
    required Future<void> Function() onDeletionConfirmed,
  }) async {
    final bool isDeletionApproved =
        await CustomAlertDialog.showConfirmationAlertDialog(
      context: context,
      title: 'Danger Zone!',
      content: 'Are you sure you want to delete your account?',
    );

    if (isDeletionApproved) {
      await onDeletionConfirmed();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileScreenControllerProvider);
    return BottomAppBar(
      elevation: 0,
      color: Colors.transparent,
      child: SizedBox(
        height: 105,
        child: state.signOutAsyncValue.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Row(
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
                          onTap: () {
                            final navigatorContext = Navigator.of(context);
                            _showSignOutConfirmationAlert(
                              context: context,
                              onSignOutConfirmed: () async {
                                final bool success = await ref
                                    .read(profileScreenControllerProvider
                                        .notifier)
                                    .signOut();

                                if (success) {
                                  navigatorContext.pushNamedAndRemoveUntil(
                                      RouteName.loginScreen.name,
                                      (route) => false);
                                }
                              },
                            );
                          },
                          buttonText: "Log out",
                          buttonColor: kDarkBlue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AccounDeletionButton(
                    onPressed: () {
                      final navigatorContext = Navigator.of(context);
                      _showAccountDeletionConfirmation(
                        context: context,
                        onDeletionConfirmed: () async {
                          final bool success = await ref
                              .read(profileScreenControllerProvider.notifier)
                              .deleteUserAccount();

                          if (success) {
                            navigatorContext.pushNamedAndRemoveUntil(
                                RouteName.signUpScreen.name, (route) => false);
                          }
                        },
                      );
                    },
                  )
                ],
              ),
      ),
    );
  }
}
