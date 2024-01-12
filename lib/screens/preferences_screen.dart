import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/screens/auth_screen.dart';
import 'package:mobilni_zpevnik/screens/screen_template.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobilni_zpevnik/service/auth_service.dart';

class PreferencesScreen extends StatelessWidget {
  final _authService = GetIt.I<AuthService>();

  PreferencesScreen({super.key});

  void _signUserOut() {
    _authService.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: _authService.userStream,
        builder: (context, snapshot) {
          return AuthScreen(
            child: ScreenTemplate(
              appBar: AppBar(
                title: Text('preferences'.i18n()),
              ),
              body: ListView(
                children: [
                  SwitchListTile(
                    title: Text('dark-mode'.i18n()),
                    value: true,
                    onChanged: null,
                  ),
                  ListTile(
                    title: Text('logout'.i18n()),
                    subtitle: Text(snapshot.data?.email ?? ''),
                    onTap: _signUserOut,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
