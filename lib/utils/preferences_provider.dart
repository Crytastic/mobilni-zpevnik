import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:mobilni_zpevnik/models/preferences.dart';
import 'package:mobilni_zpevnik/service/user_data_service.dart';

class PreferencesProvider extends ChangeNotifier {
  Preferences _preferences;
  final _userDataService = GetIt.I<UserDataService>();

  PreferencesProvider() : _preferences = Preferences(showChords: true) {
    _initializePreferences();
  }

  Preferences get preferences => _preferences;

  void _initializePreferences() {
    _userDataService.preferencesStream.listen((newPreferences) {
      _preferences = newPreferences;
      notifyListeners();
    });
  }

  void updatePreferences(Preferences newPreferences) {
    _preferences = newPreferences;
    notifyListeners();
    _userDataService.updatePreferences(newPreferences);
  }
}
