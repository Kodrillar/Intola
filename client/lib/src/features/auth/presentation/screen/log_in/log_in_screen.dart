import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intola/src/routing/route.dart';
import 'package:intola/src/utils/validation_error_text.dart';
import 'package:intola/src/features/auth/data/repository/auth_repository.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/alert_dialog.dart';
import 'package:intola/src/features/auth/presentation/auth_button.dart';
import 'package:intola/src/features/auth/presentation/auth_option_text.dart';
import 'package:intola/src/widgets/text_field.dart';

AuthRepository _authRepository = AuthRepository();

class LoginScreen extends StatefulWidget {
  static const id = "/loginScreen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? emailErrorText;
  String? passwordErrorText;
  bool processingRequest = false;
  bool obscureTextField = true;

  Future<Map<String, dynamic>> loginUser() async {
    Map<String, dynamic> loginData = await _authRepository.loginUser(
      endpoint: endpoints["loginUser"],
      userEmail: emailController.text.trim(),
      userPassword: passwordController.text.trim(),
    );
    return loginData;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 100),
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
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
            ),
            onChanged: onChangedOfTextField(passwordController),
          ),
          processingRequest
              ? const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
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
              Navigator.pushNamed(
                context,
                RouteName.signUpScreen.name,
              );
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
      if (userData["wrongPassword"] == true) {
        setState(() {
          passwordErrorText = "Wrong/Invalid passowrd!";

          processingRequest = false;
        });
        return;
      }

      await SecureStorage.storage.write(key: "token", value: userData["token"]);
      await SecureStorage.storage.write(
        key: "userName",
        value: emailController.text.trim(),
      );
      Navigator.pushNamed(
        context,
        RouteName.homeScreen.name,
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
