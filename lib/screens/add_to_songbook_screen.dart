import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/screens/auth_screen.dart';
import 'package:mobilni_zpevnik/screens/screen_template.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/service/songbook_service.dart';
import 'package:mobilni_zpevnik/models/songbook.dart';
import 'package:mobilni_zpevnik/widgets/songbooks_stream_builder.dart';
import 'package:mobilni_zpevnik/service/auth_service.dart';
import 'package:mobilni_zpevnik/widgets/snack_notification.dart';
import 'create_songbook_screen.dart';

class AddToSongbookScreen extends StatelessWidget {
  final Song song;
  final _authService = GetIt.I<AuthService>();
  final _songbookService = GetIt.I<SongbookService>();

  AddToSongbookScreen({super.key, required this.song});

  void _createNewSongbook(String name, List<Song> songs) async {
    try {
      var songbook = Songbook(
        name: name,
        songs: songs,
        ownerId: _authService.instance.currentUser?.uid,
      );
      var songbookReference = await _songbookService.createSongbook(songbook);

      await _songbookService.addSongToSongbook(songbookReference.id, song);
    } catch (e) {
      if (kDebugMode) {
        print('Error creating songbook: $e');
      }
    }
  }

  void _openCreateSongbookScreen(BuildContext context, Song song) {
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
          title: Text('add-to-songbook'.i18n()),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: ListTile(
                  title: Text('create-new-songbook'.i18n()),
                  onTap: () {
                    _openCreateSongbookScreen(context, song);
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
                        onTap: () async {
                          var message = await _songbookService
                                  .addSongToSongbook(songbook.id, song)
                              ? 'Added ${song.name} to ${songbook.name}'
                              : '${song.name} already in ${songbook.name}';
                          if (context.mounted) {
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                            SnackNotification.show(context, message);
                          }
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
