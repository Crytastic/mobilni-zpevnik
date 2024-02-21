import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobilni_zpevnik/models/preferences.dart';
import 'package:mobilni_zpevnik/service/user_data_service.dart';

class PreferencesProvider extends ChangeNotifier {
  Preferences _preferences;
  final _userDataService = GetIt.I<UserDataService>();

  PreferencesProvider() : _preferences = Preferences() {
    _initializePreferences();
  }

  Preferences get preferences => _preferences;

  void _initializePreferences() {
    _userDataService.preferencesStream.listen((newPreferences) {
      _preferences = newPreferences;
      notifyListeners();
    });
  }

  void updatePreferences({
    bool? showChords,
    bool? showHAsB,
    bool? showMiAsM,
    ThemeMode? themeMode,
    String? fontFamily,
  }) {
    _preferences = Preferences(
      showChords: showChords ?? _preferences.showChords,
      showHAsB: showHAsB ?? _preferences.showHAsB,
      showMiAsM: showMiAsM ?? _preferences.showMiAsM,
      themeMode: themeMode ?? _preferences.themeMode,
      fontFamily: fontFamily ?? _preferences.fontFamily,
    );

    notifyListeners();
    _userDataService.updatePreferences(_preferences);
  }
}
