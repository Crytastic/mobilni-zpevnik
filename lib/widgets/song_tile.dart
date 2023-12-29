import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/screens/song_screen.dart';
import 'bottom_sheet_menu.dart';
import 'colored_tile.dart';

class SongTile extends StatelessWidget {
  final Song song;
  final int index;

  const SongTile({
    Key? key,
    required this.song,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredTile(
      index: index,
      title: Text(song.name),
      subtitle: Text(song.artist),
      trailing: GestureDetector(
        onTap: () {
          BottomSheetMenu.show(context, song);
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
}
