import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/bars/bottom_navigation_bar_provider.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomBarProvider =
        Provider.of<BottomNavigationBarProvider>(context, listen: true);

    return BottomNavigationBar(
      currentIndex: bottomBarProvider.currentIndex,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      onTap: (index) {
        bottomBarProvider.currentIndex = index;
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          activeIcon: const Icon(Icons.home_rounded),
          label: 'home'.i18n(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.search_outlined),
          activeIcon: const Icon(Icons.search_rounded),
          label: 'search'.i18n(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.library_music_outlined),
          activeIcon: const Icon(Icons.library_music_rounded),
          label: 'songbooks'.i18n(),
        ),
      ],
    );
  }
}
