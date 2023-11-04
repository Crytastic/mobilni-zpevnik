import 'package:flutter/material.dart';

import 'mainpage.dart';

class SongbookApp extends StatelessWidget {
  const SongbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: MainPage(),
    );
  }
}
