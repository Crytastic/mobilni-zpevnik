import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/screens/login_screen.dart';
import 'package:mobilni_zpevnik/screens/screen_template.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginScreen();
    return ScreenTemplate(
      appBar: AppBar(
        title: Text('preferences'.i18n()),
      ),
      body: Center(
        child: Text('preferences-content'.i18n()),
      ),
    );
  }
}
