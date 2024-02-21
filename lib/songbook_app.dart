import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/utils/preferences_provider.dart';
import 'package:provider/provider.dart';
import 'package:mobilni_zpevnik/screens/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SongbookApp extends StatelessWidget {
  const SongbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    final preferencesProvider =
        Provider.of<PreferencesProvider>(context, listen: true);

    LocalJsonLocalization.delegate.directories = ['assets/i18n'];

    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocalJsonLocalization.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('cs', 'CZ'),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (supportedLocales.contains(locale)) {
          return locale;
        }

        return const Locale('en', 'US');
      },
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: preferencesProvider.preferences.themeMode,
      home: const MainScreen(),
    );
  }
}
