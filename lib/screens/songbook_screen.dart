import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/screens/screen_template.dart';
import 'package:mobilni_zpevnik/widgets/song_list.dart';
import 'package:mobilni_zpevnik/models/songbook.dart';

class SongbookScreen extends StatelessWidget {
  final Songbook songbook;

  const SongbookScreen({Key? key, required this.songbook}) : super(key: key);

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
            child: SongList(songs: songbook.songs),
          )
        ],
      ),
    );
  }
}
