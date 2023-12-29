import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/screens/song_screen.dart';
import '../models/songbook.dart';
import 'bottom_sheet_menu.dart';
import 'colored_tile.dart';

class SongbookTile extends StatelessWidget {
  final Songbook songbook;
  final int index;

  const SongbookTile({
    Key? key,
    required this.songbook,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredTile(
      index: index,
      title: Text(songbook.name),
      subtitle: Text('${songbook.songs.length} songs'),
      onTap: () {},
    );
  }
}
