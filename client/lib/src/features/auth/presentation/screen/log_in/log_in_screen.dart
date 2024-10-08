import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/auth/presentation/auth_controller.dart';
import 'package:intola/src/routing/route.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/utils/text_field_validator.dart';
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

  String get email => emailController.text.trim().toLowerCase();
  String get password => passwordController.text.trim();

  Future<void> _loginUser() async {
    final navigator = Navigator.of(context);
    if (_formKey.currentState!.validate()) {
      final bool loginIsSuccessful =
          await ref.read(authControllerProvider.notifier).logInUser(
                email: email,
                password: password,
              );

      if (loginIsSuccessful) {
        navigator.pushNamedAndRemoveUntil(
            RouteName.homeScreen.name, (route) => false);
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
      authControllerProvider,
      (previousState, newState) => newState.showErrorAlertDialog(context),
    );
    final state = ref.watch(authControllerProvider);
    bool obscureTextFieldText = ref.watch(obscureTextFieldTextProvider);
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
                  //TODO: Make this screen title reusable
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 100),
                      child: Text(
                        "Log In",
                        style: kAuthTextStyle,
                      ),
                    ),
                  ),
                  CustomTextField(
                    isEnabled: !state.isLoading,
                    labelText: "email",
                    hintText: "e.g. pabloescobar@mail.com",
                    validator: TextFieldValidator.validateEmailField,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CustomTextField(
                    isEnabled: !state.isLoading,
                    labelText: "password",
                    hintText: "e.g. V3ry\$4f3",
                    validator: TextFieldValidator.validatePasswordField,
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
                    onTap: state.isLoading ? null : _loginUser,
                  ),
                  AuthOptionText(
                    title: "New to Intola?",
                    optionText: "Sign Up",
                    optionTextStyle: kAuthOptionTextStyle.copyWith(
                      color: kDarkOrange,
                    ),
                    onTap: state.isLoading
                        ? null
                        : () {
                            Navigator.pushReplacementNamed(
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
