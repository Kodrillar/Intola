import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intola/src/models/textFieldValidation/validationErrorModel.dart';
import 'package:intola/src/repositories/auth/authRepository.dart';
import 'package:intola/src/screens/auth/signUpScreen.dart';
import 'package:intola/src/screens/homeScreen.dart';
import 'package:intola/src/services/api.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/alertDialog.dart';
import 'package:intola/src/widgets/buttons/authButton.dart';
import 'package:intola/src/widgets/authOptionText.dart';
import 'package:intola/src/widgets/textField.dart';
import '../../utils/secureStorage.dart';

AuthRepository _authRepository = AuthRepository();

class LoginScreen extends StatefulWidget {
  static const id = "/loginScreen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? emailErrorText;
  String? passwordErrorText;
  bool processingRequest = false;
  bool obscureTextField = true;

  Future<Map<String, dynamic>> loginUser() async {
    var loginData = await _authRepository.loginUser(
      endpoint: endpoints["loginUser"],
      userEmail: emailController.text.trim(),
      userPassword: passwordController.text.trim(),
    );
    return loginData;
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
                "Login",
                style: kAuthTextStyle,
              ),
            ),
          ),
          CustomTextField(
            labelText: "email",
            hintText: "email",
            controller: emailController,
            errorText: emailErrorText,
            onChanged: onChangedOfTextField(emailController),
          ),
          CustomTextField(
            labelText: "password",
            hintText: "password",
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
            onChanged: onChangedOfTextField(passwordController),
          ),
          processingRequest
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: kDarkBlue,
                    ),
                  ),
                )
              : AuthButton(
                  buttonName: "Login",
                  onTap: () {
                    //to prevent 'processingRequest from always becoming 'true:'
                    //set processingRequest to be 'true' before calling 'textFieldValidation logic '
                    setState(() {
                      processingRequest = true;
                    });
                    textFieldValidationLogic();
                  },
                ),
          AuthOptionText(
            title: "New to Intola?",
            optionText: "Sign Up",
            optionTextStyle: kAuthOptionTextStyle.copyWith(
              color: kDarkOrange,
            ),
            onTap: () {
              Navigator.pushNamed(context, SignUpScreen.id);
            },
          )
        ],
      ),
    );
  }

  onChangedOfTextField(TextEditingController controller) {
    return (newValue) {
      setState(() {
        controller == emailController && controller.text.trim().isNotEmpty
            ? emailErrorText = null
            : null;

        controller == passwordController && controller.text.trim().isNotEmpty
            ? passwordErrorText = null
            : null;
      });
    };
  }

  void textFieldValidationLogic() async {
    // Refactor all controller.text to a single variable;
    if (emailController.text.trim().isEmpty) {
      setState(() {
        processingRequest = false;
        emailErrorText = ValidationErrorModel.validationError["emailError"];
      });

      return;
    }

    if (passwordController.text.trim().isEmpty) {
      setState(() {
        processingRequest = false;
        passwordErrorText =
            ValidationErrorModel.validationError["passwordError"];
      });
      return;
    }
    try {
      var userData = await loginUser();

      if (userData["userAlreadyExist"] == false) {
        setState(() {
          emailErrorText = "User does not exist! Kindly Sign up...";

          processingRequest = false;
        });
        return;
      }
      ;
      if (userData["wrongPassword"] == true) {
        setState(() {
          passwordErrorText = "Wrong/Invalid passowrd!";

          processingRequest = false;
        });
        return;
      }
      ;

      await SecureStorage.storage.write(key: "token", value: userData["token"]);
      await SecureStorage.storage
          .write(key: "userName", value: emailController.text.trim());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen(
              user: emailController.text.trim(),
            ),
          ),
          (route) => false);
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
