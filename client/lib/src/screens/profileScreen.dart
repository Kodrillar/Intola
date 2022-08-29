import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intola/src/models/profile_Model.dart';
import 'package:intola/src/repositories/profile/profile_repository.dart';
import 'package:intola/src/screens/auth/logIn_Screen.dart';
import 'package:intola/src/services/api.dart';
import 'package:intola/src/utils/constant.dart';

import '../widgets/alertDialog.dart';
import '../widgets/buttons/customButton.dart';

ProfileRepository _profileRepository = ProfileRepository();

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({this.userEmail});

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
                  Icon(
                    Icons.account_circle,
                    size: 250,
                    color: kDarkBlue,
                  ),
                  Text(
                    "${data!.fullname}",
                    style: kProductNameStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${data.email}",
                    style: kProductDetailStyle.copyWith(
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  _buildBottomAppBar() {
    return BottomAppBar(
      elevation: 0,
      child: Container(
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
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        "Profile",
        style: kAppBarTextStyle,
      ),
    );
  }
}
