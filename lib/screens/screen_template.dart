import 'package:flutter/material.dart';

class ScreenTemplate extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? bottomBar;
  final Widget body;
  final FloatingActionButton? floatingActionButton;

  const ScreenTemplate({
    super.key,
    required this.appBar,
    this.bottomBar,
    required this.body,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomBar,
      body: SafeArea(
        child: body,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
