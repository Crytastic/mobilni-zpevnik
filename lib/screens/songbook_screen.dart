import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobilni_zpevnik/screens/screen_template.dart';
import 'package:mobilni_zpevnik/widgets/song_list.dart';
import 'package:mobilni_zpevnik/models/songbook.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import '../service/song_service.dart';
import '../service/songbook_service.dart';

class SongbookScreen extends StatelessWidget {
  final Songbook songbook;
  final _songbookService = GetIt.I<SongbookService>();

  SongbookScreen({Key? key, required this.songbook}) : super(key: key);

  void _removeSongFromSongbook(Song song) {
    _songbookService.removeSongFromSongbook(songbook.id, song.id);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(songbook.name),
          const SizedBox(height: 8.0),
          Text('Number of Songs: ${songbook.songs.length}'),
          const SizedBox(height: 8.0),
          Text('${FirebaseAuth.instance.currentUser?.email}'),
          const SizedBox(height: 8.0),
          const Divider(height: 1),
          Expanded(
            child: StreamBuilder<List<Song>>(
              stream: _songbookService.songbooksStream.map((songbooks) =>
                  songbooks
                      .firstWhere((songbook) => songbook.id == this.songbook.id)
                      .songs),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final songs = snapshot.data!;
                songs.sort((a, b) {
                  return a.name.toLowerCase().compareTo(b.name.toLowerCase());
                });

                if (songs.isEmpty) {
                  return const Center(child: Text('No songs available.'));
                }

                return SongList(
                  songs: songbook.songs,
                  canRemoveFromSongbook: true,
                  onRemoveFromSongbookTap: (Song song) {
                    _removeSongFromSongbook(song);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
