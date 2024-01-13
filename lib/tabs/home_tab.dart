import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobilni_zpevnik/service/song_service.dart';
import 'package:mobilni_zpevnik/service/user_data_service.dart';
import 'package:mobilni_zpevnik/widgets/handling_stream_builder.dart';
import 'package:mobilni_zpevnik/widgets/song_list.dart';
import 'package:mobilni_zpevnik/models/user_data.dart';
import 'package:mobilni_zpevnik/models/song.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final _songService = GetIt.I<SongService>();
  final _userDataService = GetIt.I<UserDataService>();

  @override
  Widget build(BuildContext context) {
    return HandlingStreamBuilder<List<Song>>(
      stream: _songService.songsStream,
      builder: (context, songs) {
        return StreamBuilder<UserData?>(
          stream: _userDataService.currentUserUserDataStream,
          builder: (context, userDataSnapshot) {
            /// Has error, something is wrong
            if (userDataSnapshot.hasError) {
              return Center(child: Text('Error: ${userDataSnapshot.error!}'));
            }

            /// Has user data, show latest songs
            if (userDataSnapshot.hasData) {
              return SongList(songs: userDataSnapshot.data!.latestSongs);
            }

            /// Doesn't have user data or some other issue, show random songs
            return SongList(songs: songs);
          },
        );
      },
    );
  }
}
