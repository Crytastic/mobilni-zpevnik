import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/screens/preferences_screen.dart';

class PreferencesButton extends StatelessWidget {
  const PreferencesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => PreferencesScreen()),
        );
      },
    );
  }
}
