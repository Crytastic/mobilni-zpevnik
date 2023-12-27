import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/screens/auth_screen.dart';
import 'package:mobilni_zpevnik/screens/screen_template.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({super.key});

  void _signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return AuthScreen(
      child: ScreenTemplate(
        appBar: AppBar(
          title: Text('preferences'.i18n()),
        ),
        body: ListView(
          children: [
            const SwitchListTile(
              title: Text("Dark Mode"),
              value: true,
              onChanged: null,
            ),
            ListTile(
              title: Text('logout'.i18n()),
              subtitle: Text(user?.email ?? ''),
              onTap: _signUserOut,
            ),
          ],
        ),
      ),
    );
  }
}
