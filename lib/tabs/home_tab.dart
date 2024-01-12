import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobilni_zpevnik/service/auth_service.dart';
import 'package:mobilni_zpevnik/service/song_service.dart';
import 'package:mobilni_zpevnik/service/user_data_service.dart';
import 'package:mobilni_zpevnik/widgets/handling_stream_builder.dart';
import 'package:mobilni_zpevnik/widgets/song_list.dart';
import 'package:mobilni_zpevnik/models/user_data.dart';

import '../models/song.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final _songService = GetIt.I<SongService>();
  final _userDataService = GetIt.I<UserDataService>();
  final _authService = GetIt.I<AuthService>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _authService.instance.currentUser != null
          ? _userDataService
              .userDataExists(_authService.instance.currentUser!.uid)
          : Future.value(false),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          /// Waiting for data
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          /// Error
          return const Center(child: Text('Error checking user data.'));
        } else if (!snapshot.data!) {
          /// User doesn't have any UserData in Firestore, return random songs
          return HandlingStreamBuilder<List<Song>>(
            stream: _songService.songsStream,
            builder: (context, songs) {
              if (songs.isEmpty) {
                return const Center(child: Text('No songs available.'));
              }

              return SongList(songs: songs.toList());
            },
          );
        } else {
          /// User does have UserData in Firestore, return last played songs
          return HandlingStreamBuilder<UserData?>(
            stream: _userDataService.currentUserUserDataStream,
            builder: (context, userData) {
              if (userData == null || userData.latestSongs.isEmpty) {
                return const Center(child: Text('No songs available.'));
              }

              return SongList(songs: userData.latestSongs.toList());
            },
          );
        }
      },
    );
  }
}
