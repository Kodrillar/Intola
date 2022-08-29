import 'dart:io';

import 'package:flutter/material.dart';

import 'package:intola/src/models/textFieldValidation/validationError_Model.dart';
import 'package:intola/src/repositories/auth/auth_Repository.dart';
import 'package:intola/src/screens/auth/logIn_Screen.dart';
import 'package:intola/src/screens/homeScreen.dart';
import 'package:intola/src/services/api.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/alertDialog.dart';
import 'package:intola/src/widgets/buttons/authButton.dart';
import 'package:intola/src/widgets/authOptionText.dart';
import 'package:intola/src/widgets/textField.dart';

import '../../utils/secureStorage.dart';

AuthRepository _authRepository = AuthRepository();

class SignUpScreen extends StatefulWidget {
  static const id = "/signUpScreen";
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? fullnameErrorText;
  String? emailErrorText;
  String? passwordErrorText;

  bool processingRequest = false;
  bool obscureTextField = true;

  Future signUp() async {
    var responseBody = await _authRepository.registerUser(
      endpoint: endpoints["registerUser"],
      userFullname: fullnameController.text,
      userPassword: passwordController.text.trim(),
      userEmail: emailController.text.trim(),
    );
    return responseBody;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 120),
              child: Text(
                "Sign Up",
                style: kAuthTextStyle,
              ),
            ),
          ),
          CustomTextField(
            hintText: "fullname",
            labelText: "fullname",
            controller: fullnameController,
            errorText: fullnameErrorText,
            onChanged: onChanged(fullnameController),
          ),
          CustomTextField(
            hintText: "email",
            labelText: "email",
            controller: emailController,
            errorText: emailErrorText,
            onChanged: onChanged(emailController),
          ),
          CustomTextField(
            hintText: "password",
            labelText: "password",
            controller: passwordController,
            errorText: passwordErrorText,
            obscureText: obscureTextField,
            visibilityIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureTextField = !obscureTextField;
                });
              },
              icon: obscureTextField
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility),
            ),
            onChanged: onChanged(passwordController),
          ),
          processingRequest
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: kDarkOrange,
                    ),
                  ),
                )
              : AuthButton(
                  buttonName: "Sign Up",
                  onTap: () async {
                    setState(() {
                      processingRequest = true;
                    });
                    textFieldValidationLogic();
                  },
                ),
          AuthOptionText(
            title: "Already have an account?",
            optionText: "Login",
            optionTextStyle: kAuthOptionTextStyle.copyWith(
              color: kDarkOrange,
            ),
            onTap: () {
              Navigator.pushNamed(context, LoginScreen.id);
            },
          )
        ],
      ),
    );
  }

  onChanged(TextEditingController controller) {
    return (newValue) {
      setState(() {
        // print(controller.text);
        controller == fullnameController && controller.text.trim().isNotEmpty
            ? fullnameErrorText = null
            : null;

        controller == emailController && controller.text.trim().isNotEmpty
            ? emailErrorText = null
            : null;

        controller == passwordController && controller.text.trim().isNotEmpty
            ? passwordErrorText = null
            : null;
      });
    };
  }

// revisit this logic later
  void textFieldValidationLogic() async {
    if (fullnameController.text.trim().isEmpty) {
      setState(() {
        fullnameErrorText =
            ValidationErrorModel.validationError["fullnameError"];
        processingRequest = false;
      });
      return;
    }

    if (emailController.text.trim().isEmpty) {
      setState(() {
        emailErrorText = ValidationErrorModel.validationError["emailError"];
        processingRequest = false;
      });

      return;
    }

    if (passwordController.text.trim().isEmpty) {
      setState(() {
        passwordErrorText =
            ValidationErrorModel.validationError["passwordError"];
        processingRequest = false;
      });

      return;
    }

    try {
      var userData = await signUp();

      if (userData["userAlreadyExist"]) {
        setState(() {
          emailErrorText = "email is already registered! Kindly LogIn...";

          processingRequest = false;
        });

        return;
      }
      await SecureStorage.storage.write(key: "token", value: userData["token"]);
      await SecureStorage.storage
          .write(key: "userName", value: emailController.text.trim());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              HomeScreen(user: emailController.text.trim()),
        ),
      );
    } on SocketException {
      setState(() {
        processingRequest = false;
      });
      alertDialog(
        context: context,
        title: "Network Error",
        content: "Unable to connect to the internet!",
      );
    } catch (_) {
      setState(() {
        processingRequest = false;
      });
      alertDialog(
        context: context,
        title: "Internal Error",
        content: "Server Error, try again!",
      );
    }
  }
}
