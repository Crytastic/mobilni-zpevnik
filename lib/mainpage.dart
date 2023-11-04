import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/top_bar.dart';

import 'bottom_bar.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    const int tabsCount = 3;

    return DefaultTabController(
      initialIndex: 1,
      length: tabsCount,
      child: Scaffold(
        appBar: const TopBar(),
        bottomNavigationBar: const BottomBar(),
        body: TabBarView(
          children: <Widget>[
            ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: Text('Song $index'),
                );
              },
            ),
            ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: Text('Song suggestion $index'),
                );
              },
            ),
            ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: Text('Songbook $index'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
