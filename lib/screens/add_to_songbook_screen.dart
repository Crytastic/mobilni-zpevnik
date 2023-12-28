import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:localization/localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobilni_zpevnik/screens/auth_screen.dart';
import 'package:mobilni_zpevnik/screens/screen_template.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/service/songbook_service.dart';
import 'package:mobilni_zpevnik/models/songbook.dart';

import 'create_songbook_screen.dart';

class AddToSongbookScreen extends StatelessWidget {
  final Song song;
  final _songbookService = GetIt.I<SongbookService>();

  AddToSongbookScreen({Key? key, required this.song}) : super(key: key);

  void _createNewSongbook(String name, List<Song> songs) async {
    await _songbookService.createSongbook(Songbook(name: name, songs: songs));
  }

  void _openCreateSongbookScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateSongbookScreen(
          onCreate: _createNewSongbook,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreen(
      child: ScreenTemplate(
        appBar: AppBar(
          title: const Text('Add to Songbook'),
        ),
        body: Column(
          children: [
            ListTile(
              title: const Text('Create New Songbook'),
              onTap: () {
                _openCreateSongbookScreen(context);
              },
            ),
            const Divider(
              height: 1,
            ),
            StreamBuilder<List<Songbook>>(
              stream: _songbookService.songbooksStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final songbooks = snapshot.data!;
                songbooks.sort((a, b) {
                  return a.name.toLowerCase().compareTo(b.name.toLowerCase());
                });

                if (songbooks.isEmpty) {
                  return const Center(child: Text('No songsbooks available.'));
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: songbooks.length,
                  itemBuilder: (context, index) {
                    var songbook = songbooks[index];
                    return ListTile(
                      title: Text(songbook.name),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
