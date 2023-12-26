import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/screens/song_screen.dart';

class SongTile extends StatelessWidget {
  final Song song;
  final int index;

  const SongTile({super.key, required this.song, required this.index});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return ListTile(
      tileColor: index.isOdd ? oddItemColor : evenItemColor,
      title: Text('${song.name} - ${song.artist}'),
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
