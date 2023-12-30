import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobilni_zpevnik/screens/screen_template.dart';
import 'package:mobilni_zpevnik/widgets/song_list.dart';
import 'package:mobilni_zpevnik/models/songbook.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/service/songbook_service.dart';

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
          _buildSongbookHeader(context),
          const Divider(height: 1),
          _buildSongbookListOfSongs(),
        ],
      ),
    );
  }

  Widget _buildSongbookHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8.0),
              _buildSongbookName(),
              const SizedBox(height: 8.0),
              _buildUserName(),
              const SizedBox(height: 8.0),
              _buildNumberOfSongs(),
              const SizedBox(height: 8.0),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNumberOfSongs() {
    return Text(
      'Number of Songs: ${songbook.songs.length}',
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildUserName() {
    return Row(
      children: [
        const Icon(Icons.account_circle_rounded),
        const SizedBox(width: 8.0),
        Text(
          '${FirebaseAuth.instance.currentUser?.displayName}',
        ),
      ],
    );
  }

  Widget _buildSongbookName() {
    return Text(
      songbook.name,
      style: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSongbookListOfSongs() {
    return Expanded(
      child: StreamBuilder<List<Song>>(
        stream: _songbookService.songbooksStream.map((songbooks) => songbooks
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
    );
  }
}
