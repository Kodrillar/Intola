import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/auth/presentation/auth_button.dart';
import 'package:intola/src/features/auth/presentation/auth_option_text.dart';
import 'package:intola/src/routing/route.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/utils/text_field_validator.dart';
import 'package:intola/src/widgets/annotated_region.dart';
import 'package:intola/src/widgets/async_value_display.dart';
import 'package:intola/src/widgets/text_field.dart';

import '../../auth_controller.dart';

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
    final navigator = Navigator.of(context);
    if (_formKey.currentState!.validate()) {
      final bool signUpIsSuccessful =
          await ref.read(authControllerProvider.notifier).signUpUser(
                fullName: fullName,
                email: email,
                password: password,
              );

      if (signUpIsSuccessful) {
        navigator.pushNamedAndRemoveUntil(
            RouteName.homeScreen.name, (route) => false);
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
      authControllerProvider,
      (previousState, newState) => newState.showErrorAlertDialog(context),
    );
    final state = ref.watch(authControllerProvider);
    final bool obscureTextFieldText = ref.watch(obscureTextFieldTextProvider);
    return Scaffold(
      body: SystemUIOverlayAnnotatedRegion(
        systemUiOverlayStyle: SystemUiOverlayStyle.dark,
        //TODO : Abstract Form
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    isEnabled: !state.isLoading,
                    hintText: "e.g. Zara Larsson",
                    labelText: "full name",
                    controller: fullnameController,
                    validator: TextFieldValidator.validateFullnameField,
                  ),
                  CustomTextField(
                    isEnabled: !state.isLoading,
                    hintText: "e.g. pabloescobar@mail.com",
                    labelText: "email",
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: TextFieldValidator.validateEmailField,
                  ),
                  CustomTextField(
                    isEnabled: !state.isLoading,
                    hintText: "e.g. Ucan'tcatchme90",
                    labelText: "password",
                    controller: passwordController,
                    obscureText: obscureTextFieldText,
                    validator: TextFieldValidator.validatePasswordField,
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
                    onTap: state.isLoading ? null : () => _signUpUser(),
                  ),
                  AuthOptionText(
                    title: "Already have an account?",
                    optionText: "Log In",
                    optionTextStyle: kAuthOptionTextStyle.copyWith(
                      color: kDarkOrange,
                    ),
                    onTap: state.isLoading
                        ? null
                        : () => Navigator.pushReplacementNamed(
                              context,
                              RouteName.loginScreen.name,
                            ),
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
