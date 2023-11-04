import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('preferences'.i18n()),
      ),
      body: Center(
        child: Text('preferences-text'.i18n()),
      ),
    );
  }
}
