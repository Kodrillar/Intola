import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intola/src/features/auth/presentation/screen/log_in/log_in_screen.dart';
import 'package:intola/src/features/profile/domain/model/profile_model.dart';
import 'package:intola/src/features/profile/data/repository/profile_repository.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/alert_dialog.dart';
import 'package:intola/src/widgets/buttons/custom_button.dart';

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
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomAppBar(),
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

  _buildBottomAppBar() {
    return BottomAppBar(
      elevation: 0,
      child: SizedBox(
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CustomButton(
                  onTap: () {
                    alertDialog(
                        context: context,
                        title: "Not available!",
                        content: "coming soon...");
                  },
                  buttonName: "Update",
                  buttonColor: kDarkBlue,
                ),
              ),
              Center(
                child: CustomButton(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginScreen.id, (route) => false);
                  },
                  buttonName: "Log out",
                  buttonColor: kDarkBlue,
                ),
              ),
            ],
          )),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        color: kDarkBlue,
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text(
        "Profile",
        style: kAppBarTextStyle,
      ),
    );
  }
}
