import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/screens/song_screen.dart';
import 'bottom_sheet_menu.dart';

class SongTile extends StatelessWidget {
  final Song song;
  final int index;
  final Function(String) onOptionSelected;

  const SongTile({
    Key? key,
    required this.song,
    required this.index,
    required this.onOptionSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return ListTile(
      tileColor: index.isOdd ? oddItemColor : evenItemColor,
      title: Text(song.name),
      subtitle: Text(song.artist),
      trailing: GestureDetector(
        onTap: () {
          _showBottomSheetMenu(context);
        },
        child: const Icon(Icons.more_vert),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SongScreen(song: song),
          ),
        );
      },
    );
  }

  void _showBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetMenu(
          song: song,
          onOptionSelected: (String) {},
        );
      },
    );
  }
}
