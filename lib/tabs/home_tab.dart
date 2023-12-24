import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/screens/song_screen.dart';
import 'package:mobilni_zpevnik/service/song_service.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final _songService = GetIt.I<SongService>();

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return StreamBuilder<List<Song>>(
      stream: _songService.songsStream,
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

        return ListView.builder(
          itemCount: songs.length,
          itemBuilder: (context, index) {
            final song = songs[index];

            return ListTile(
              tileColor: index.isOdd ? oddItemColor : evenItemColor,
              title: Text('${song.name} - ${song.artist}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SongScreen(song: song),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
