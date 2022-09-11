import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intola/src/features/profile/domain/model/profile_model.dart';
import 'package:intola/src/features/profile/data/repository/profile_repository.dart';
import 'package:intola/src/features/profile/presentation/profile_app_bar.dart';
import 'package:intola/src/features/profile/presentation/profile_bottom_app_bar.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/alert_dialog.dart';

ProfileRepository _profileRepository = ProfileRepository();

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, this.userEmail}) : super(key: key);

  final userEmail;
  static const id = "/profileScreen";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData;

  Future<ProfileModel> getUser() async {
    try {
      userData = await _profileRepository.getUser(
          endpoint: endpoints["getUser"]! + "/${widget.userEmail}");
    } on SocketException {
      alertDialog(
        context: context,
        title: "Network Error",
        content: "Unable to connect to the internet!",
      );
    } catch (ex) {
      alertDialog(
        context: context,
        title: "An Error occurred",
        content: "Contact support team",
      );
    }

    return userData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProfileAppBar(),
      bottomNavigationBar: const ProfileBottomAppBar(),
      body: FutureBuilder<ProfileModel>(
        future: getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.account_circle,
                    size: 250,
                    color: kDarkBlue,
                  ),
                  Text(
                    data!.fullname,
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
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
