import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/screens/screen_template.dart';
import 'package:mobilni_zpevnik/widgets/common_text_field.dart';

import 'package:mobilni_zpevnik/widgets/common_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void _signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      appBar: AppBar(
        title: Text('login'.i18n()),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 25),
              Text('login-directive'.i18n()),
              const SizedBox(height: 25),
              CommonTextField(
                controller: usernameController,
                hintText: 'username'.i18n(),
                obscureText: false,
              ),
              const SizedBox(height: 25),
              CommonTextField(
                controller: passwordController,
                hintText: 'password'.i18n(),
                obscureText: true,
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('forgot-password'.i18n()),
                ],
              ),
              const SizedBox(height: 25),
              CommonButton(
                onPressed: _signUserIn,
                label: 'sign-in'.i18n(),
              ),
              const SizedBox(height: 25),
              _buildDivider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Colors.grey,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text('or'.i18n()),
        ),
        const Expanded(
          child: Divider(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
