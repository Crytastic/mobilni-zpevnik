import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/preferences_screen.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Mobilní zpěvník"),
      notificationPredicate: (ScrollNotification notification) {
        return notification.depth == 1;
      },
      scrolledUnderElevation: 4.0,
      shadowColor: Theme.of(context).shadowColor,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => PreferencesScreen()),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
