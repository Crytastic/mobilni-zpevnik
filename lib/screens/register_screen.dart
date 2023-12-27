import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/screens/login_error_notifier.dart';
import 'package:mobilni_zpevnik/screens/screen_template.dart';
import 'package:mobilni_zpevnik/widgets/common_square_button.dart';
import 'package:mobilni_zpevnik/widgets/common_text_button.dart';
import 'package:mobilni_zpevnik/widgets/common_text_field.dart';
import 'package:mobilni_zpevnik/widgets/common_button.dart';
import 'package:provider/provider.dart';
import 'package:mobilni_zpevnik/screens/login_screen.dart';
import 'package:mobilni_zpevnik/widgets/custom_divider.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _signUserUp(LoginErrorProvider loginErrorProvider) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        loginErrorProvider.setEmailErrorMessage("Invalid e-mail.");
      } else if (e.code == 'invalid-credential') {
        loginErrorProvider.setPasswordErrorMessage(
            "Wrong password. Try again or click Forgot password to reset it.");
      } else if (e.code == 'missing-password') {
        loginErrorProvider.setPasswordErrorMessage("Missing password.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginErrorProvider =
        Provider.of<LoginErrorProvider>(context, listen: true);

    return ScreenTemplate(
      appBar: AppBar(
        title: Text('register-now'.i18n()),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
                Text('register-directive'.i18n()),
                const SizedBox(height: 25),
                CommonTextField(
                  controller: emailController,
                  hintText: 'e-mail'.i18n(),
                  obscureText: false,
                  errorText: loginErrorProvider.emailErrorMessage,
                ),
                const SizedBox(height: 25),
                CommonTextField(
                  controller: passwordController,
                  hintText: 'password'.i18n(),
                  obscureText: true,
                  errorText: loginErrorProvider.passwordErrorMessage,
                ),
                const SizedBox(height: 25),
                CommonTextField(
                  controller: passwordController,
                  hintText: 'confirm-password'.i18n(),
                  obscureText: true,
                  errorText: loginErrorProvider.passwordErrorMessage,
                ),
                const SizedBox(height: 25),
                CommonButton(
                  onPressed: () {
                    _signUserUp(loginErrorProvider);
                  },
                  label: 'sign-up'.i18n(),
                ),
                const SizedBox(height: 25),
                const CustomDivider(),
                const SizedBox(height: 25),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonSquareButton(
                      imagePath: "assets/images/google-logo.png",
                    )
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'have-account'.i18n(),
                    ),
                    const SizedBox(width: 4),
                    CommonTextButton(
                      text: 'login'.i18n(),
                      route: LoginScreen(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
