import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Tab(
            icon: const Icon(Icons.home_rounded),
          ),
          Tab(
            icon: const Icon(Icons.search),
          ),
          Tab(
            icon: const Icon(Icons.library_music),
          ),
        ],
      ),
    );
  }
}
