import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/screens/login_error_notifier.dart';
import 'package:mobilni_zpevnik/service/ioc_container.dart';
import 'package:mobilni_zpevnik/songbook_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobilni_zpevnik/utils/auto_scroll_provider.dart';
import 'package:mobilni_zpevnik/utils/preferences_provider.dart';
import 'package:provider/provider.dart';
import 'bars/bottom_navigation_bar_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  IoCContainer.setup();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavigationBarProvider>(
          create: (_) => BottomNavigationBarProvider(),
        ),
        ChangeNotifierProvider<AutoScrollProvider>(
          create: (_) => AutoScrollProvider(),
        ),
        ChangeNotifierProvider<LoginErrorProvider>(
          create: (_) => LoginErrorProvider(),
        ),
        ChangeNotifierProvider<PreferencesProvider>(
          create: (_) => PreferencesProvider(),
        ),
      ],
      child: const SongbookApp(),
    ),
  );
}
