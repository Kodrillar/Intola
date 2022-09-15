import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/profile/data/repository/profile_repository.dart';
import 'package:intola/src/features/profile/presentation/profile_app_bar.dart';
import 'package:intola/src/features/profile/presentation/profile_bottom_app_bar.dart';
import 'package:intola/src/utils/constant.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(fetchUserProfileProvider);
    return Scaffold(
      appBar: const ProfileAppBar(),
      bottomNavigationBar: const ProfileBottomAppBar(),
      body: userProfile.when(
        data: (data) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        //TODO: change error widget
        error: (error, stackTrace) => ErrorWidget(error),
      ),
    );
  }
}
