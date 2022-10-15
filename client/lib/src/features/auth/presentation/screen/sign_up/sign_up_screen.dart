import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/auth/presentation/auth_button.dart';
import 'package:intola/src/features/auth/presentation/auth_option_text.dart';
import 'package:intola/src/features/auth/presentation/auth_screen_controller.dart';
import 'package:intola/src/routing/route.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/utils/validation_error_text.dart';
import 'package:intola/src/widgets/annotated_region.dart';
import 'package:intola/src/widgets/async_value_display.dart';
import 'package:intola/src/widgets/text_field.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String get fullName => fullnameController.text.trim();
  String get email => emailController.text.trim();
  String get password => passwordController.text.trim();

  Future<void> _signUpUser() async {
    if (_formKey.currentState!.validate()) {
      final bool signUpIsSuccessful =
          await ref.read(authScreenControllerProvider.notifier).signUpUser(
                fullName: fullName,
                email: email,
                password: password,
              );

      if (signUpIsSuccessful) {
        Navigator.pushNamed(
          context,
          RouteName.homeScreen.name,
        );
      }
    }
  }

  @override
  void dispose() {
    fullnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      authScreenControllerProvider,
      (previousState, newState) => newState.showErrorAlertDialog(context),
    );
    final state = ref.watch(authScreenControllerProvider);
    final bool obscureTextFieldText = ref.watch(obscureTextFieldTextProvider);
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
                        "Sign Up",
                        style: kAuthTextStyle,
                      ),
                    ),
                  ),
                  CustomTextField(
                    hintText: "fullname",
                    labelText: "fullname",
                    controller: fullnameController,
                    validator: (String? value) {
                      if (value!.trim().isEmpty) {
                        return ValidationErrorMessage.fullnameError.message;
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    hintText: "email",
                    labelText: "email",
                    controller: emailController,
                    validator: (String? value) {
                      if (value!.trim().isEmpty) {
                        return ValidationErrorMessage.emailError.message;
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    hintText: "password",
                    labelText: "password",
                    controller: passwordController,
                    obscureText: obscureTextFieldText,
                    validator: (String? value) {
                      if (value!.trim().isEmpty) {
                        return ValidationErrorMessage.passwordError.message;
                      }
                      return null;
                    },
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
                            'Sign Up',
                            style: kAuthButtonTextStyle,
                          ),
                    onTap: () {
                      _signUpUser();
                    },
                  ),
                  AuthOptionText(
                    title: "Already have an account?",
                    optionText: "Login",
                    optionTextStyle: kAuthOptionTextStyle.copyWith(
                      color: kDarkOrange,
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteName.loginScreen.name,
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
