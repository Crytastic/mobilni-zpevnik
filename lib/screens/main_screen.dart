import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/bars/bottom_bar.dart';
import 'package:mobilni_zpevnik/bars/top_bar.dart';
import 'package:mobilni_zpevnik/tabs/home_tab.dart';
import 'package:mobilni_zpevnik/tabs/search_tab.dart';
import 'package:mobilni_zpevnik/tabs/songbooks_tab.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const int tabsCount = 3;

    return const DefaultTabController(
      initialIndex: 1,
      length: tabsCount,
      child: Scaffold(
        appBar: TopBar(),
        bottomNavigationBar: BottomBar(),
        body: TabBarView(
          children: [
            HomeTab(),
            SearchTab(),
            SongbooksTab(),
          ],
        ),
      ),
    );
  }
}
