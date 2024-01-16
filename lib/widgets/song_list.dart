import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/widgets/song_tile.dart';
import 'package:mobilni_zpevnik/screens/add_to_songbook_screen.dart';

class SongList extends StatelessWidget {
  final List<Song> songs;
  final bool scrollable;
  final bool canAddToSongbook;
  final bool canRemoveFromSongbook;
  final VoidCallback? onAddToSongbookTap;
  final Function(Song song)? onRemoveFromSongbookTap;

  const SongList({
    super.key,
    required this.songs,
    this.scrollable = true,
    this.canAddToSongbook = true,
    this.canRemoveFromSongbook = false,
    this.onAddToSongbookTap,
    this.onRemoveFromSongbookTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: scrollable
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: songs.length,
      itemBuilder: (BuildContext context, int index) {
        return SongTile(
          song: songs[index],
          index: index,
          canAddToSongbook: canAddToSongbook,
          canRemoveFromSongbook: canRemoveFromSongbook,
          onAddToSongbookTap: onAddToSongbookTap ??
              () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddToSongbookScreen(song: songs[index]),
                  ),
                );
              },
          onRemoveFromSongbookTap: onRemoveFromSongbookTap,
        );
      },
    );
  }
}
