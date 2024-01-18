import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/screens/auth_screen.dart';
import 'package:mobilni_zpevnik/screens/screen_template.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobilni_zpevnik/service/auth_service.dart';
import 'package:mobilni_zpevnik/utils/preferences_provider.dart';
import 'package:provider/provider.dart';

class PreferencesScreen extends StatelessWidget {
  final _authService = GetIt.I<AuthService>();

  PreferencesScreen({super.key});

  void _signUserOut() {
    _authService.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final preferencesProvider =
        Provider.of<PreferencesProvider>(context, listen: true);

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
                    title: Text('show-chords'.i18n()),
                    value: preferencesProvider.preferences.showChords,
                    onChanged: (value) {
                      preferencesProvider.updatePreferences(
                        showChords: value,
                      );
                    },
                  ),
                  SwitchListTile(
                    title: Text('show-mi-as-m'.i18n()),
                    value: preferencesProvider.preferences.showMiAsM,
                    onChanged: (value) {
                      preferencesProvider.updatePreferences(
                        showMiAsM: value,
                      );
                    },
                  ),
                  SwitchListTile(
                    title: Text('show-h-as-b'.i18n()),
                    value: preferencesProvider.preferences.showHAsB,
                    onChanged: (value) {
                      preferencesProvider.updatePreferences(
                        showHAsB: value,
                      );
                    },
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
