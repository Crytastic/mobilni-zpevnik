import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/service/song_service.dart';
import 'package:mobilni_zpevnik/widgets/handling_stream_builder.dart';
import 'package:mobilni_zpevnik/widgets/song_list.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final _songService = GetIt.I<SongService>();

  @override
  Widget build(BuildContext context) {
    return HandlingStreamBuilder<List<Song>>(
      stream: _songService.songsStream,
      builder: (context, songs) {
        songs.sort((a, b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });

        if (songs.isEmpty) {
          return const Center(child: Text('No songs available.'));
        }

        return SongList(songs: songs);
      },
    );
  }
}
