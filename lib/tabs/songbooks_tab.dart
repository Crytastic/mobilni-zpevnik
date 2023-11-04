import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class SongbooksTab extends StatelessWidget {
  const SongbooksTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return ListView.builder(
      itemCount: 25,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          tileColor: index.isOdd ? oddItemColor : evenItemColor,
          title: Text('${'songbook'.i18n()} $index'),
        );
      },
    );
  }
}
