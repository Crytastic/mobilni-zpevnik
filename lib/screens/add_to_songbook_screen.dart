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
import 'package:mobilni_zpevnik/widgets/songbook_list.dart';

import '../widgets/songbooks_stream_builder.dart';
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: ListTile(
                  title: const Text('Create New Songbook'),
                  onTap: () {
                    _openCreateSongbookScreen(context);
                  },
                ),
              ),
              const Divider(
                height: 1,
              ),
              SongbooksStreamBuilder(
                builder: (BuildContext context, List<Songbook> songbooks) {
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
      ),
    );
  }
}
