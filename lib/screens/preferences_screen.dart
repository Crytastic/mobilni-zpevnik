import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/screens/auth_screen.dart';
import 'package:mobilni_zpevnik/screens/screen_template.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobilni_zpevnik/service/auth_service.dart';
import 'package:mobilni_zpevnik/utils/preferences_provider.dart';
import 'package:mobilni_zpevnik/utils/shared_ui_constants.dart';
import 'package:provider/provider.dart';

class PreferencesScreen extends StatelessWidget {
  final _authService = GetIt.I<AuthService>();

  PreferencesScreen({super.key});

  void _signUserOut() {
    _authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
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
                    title: Text('color-mode'.i18n()),
                    trailing: DropdownButton2<ThemeMode>(
                      value: preferencesProvider.preferences.themeMode,
                      onChanged: (newValue) {
                        preferencesProvider.updatePreferences(
                          themeMode: newValue,
                        );
                      },
                      items: ThemeMode.values
                          .map((ThemeMode mode) => DropdownMenuItem<ThemeMode>(
                                value: mode,
                                child: Text(mode.name.i18n()),
                              ))
                          .toList(),
                      buttonStyleData: ButtonStyleData(
                        width: 120,
                        padding: const EdgeInsets.only(
                            left: SMALL_GAP, right: SMALL_GAP),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(STANDARD_RADIUS),
                        ),
                      ),
                      dropdownStyleData: DropdownStyleData(
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(STANDARD_RADIUS),
                          color: colorScheme.surfaceVariant,
                        ),
                      ),
                    ),
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
