import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/screens/songbook_screen.dart';
import 'package:mobilni_zpevnik/models/songbook.dart';
import 'colored_tile.dart';

class SongbookTile extends StatelessWidget {
  final Songbook songbook;
  final int index;

  const SongbookTile({
    super.key,
    required this.songbook,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredTile(
      index: index,
      icon: songbook.name == 'Favorites' ? Icons.favorite : Icons.music_note,
      title: Text(songbook.name),
      subtitle: Text('${songbook.songs.length} songs'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SongbookScreen(songbook: songbook),
          ),
        );
      },
    );
  }
}
