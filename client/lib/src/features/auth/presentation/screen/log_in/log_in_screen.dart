import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/auth/presentation/log_in_screen_controller.dart';
import 'package:intola/src/features/auth/presentation/sign_up_screen_controller.dart';
import 'package:intola/src/routing/route.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/utils/validation_error_text.dart';
import 'package:intola/src/features/auth/presentation/auth_button.dart';
import 'package:intola/src/features/auth/presentation/auth_option_text.dart';
import 'package:intola/src/widgets/annotated_region.dart';
import 'package:intola/src/widgets/async_value_display.dart';
import 'package:intola/src/widgets/text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String get email => emailController.text.trim();
  String get password => passwordController.text.trim();

  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      final bool loginIsSuccessful =
          await ref.read(logInScreenControllerProvider.notifier).logInUser(
                email: email,
                password: password,
              );

      if (loginIsSuccessful) {
        Navigator.pushNamed(
          context,
          RouteName.homeScreen.name,
        );
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      logInScreenControllerProvider,
      (previousState, newState) => newState.showErrorAlertDialog(context),
    );
    final state = ref.watch(logInScreenControllerProvider);
    bool obscureTextFieldText = ref.watch(obscureTextFieldTextProvider);
    return Scaffold(
      body: SystemUIOverlayAnnotatedRegion(
        systemUiOverlayStyle: SystemUiOverlayStyle.dark,
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
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
                    validator: (String? value) {
                      if (value!.trim().isEmpty) {
                        return ValidationErrorMessage.emailError.message;
                      }
                      return null;
                    },
                    controller: emailController,
                  ),
                  CustomTextField(
                    labelText: "password",
                    hintText: "password",
                    validator: (String? value) {
                      if (value!.trim().isEmpty) {
                        return ValidationErrorMessage.passwordError.message;
                      }
                      return null;
                    },
                    controller: passwordController,
                    obscureText: obscureTextFieldText,
                    visibilityIcon: IconButton(
                      onPressed: () {
                        ref.read(obscureTextFieldTextProvider.notifier).state =
                            !obscureTextFieldText;
                      },
                      icon: obscureTextFieldText
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                  AuthButton(
                    child: state.isLoading
                        ? const CircularProgressIndicator.adaptive(
                            backgroundColor: kLightColor,
                          )
                        : const Text(
                            'Login',
                            style: kAuthButtonTextStyle,
                          ),
                    onTap: () {
                      _loginUser();
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
