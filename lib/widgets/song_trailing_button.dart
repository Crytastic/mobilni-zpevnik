import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/widgets/bottom_sheet_menu.dart';
import 'package:mobilni_zpevnik/widgets/menu_option.dart';

class SongTrailingButton extends StatelessWidget {
  final Song song;
  final List<MenuOption> menuOptions;

  const SongTrailingButton({
    super.key,
    required this.song,
    required this.menuOptions,
  });

  void _showBottomSheet(BuildContext context) {
    BottomSheetMenu.show(
      context,
      ListTile(
        title: Text(song.name),
        subtitle: Text(song.artist),
      ),
      menuOptions,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showBottomSheet(context);
      },
      child: const Icon(Icons.more_vert),
    );
  }
}
