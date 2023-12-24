import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/screens/song_screen.dart';
import 'package:mobilni_zpevnik/service/song_service.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController _searchController = TextEditingController();
  final _songService = GetIt.I<SongService>();
  List<Song> _songs = [];
  List<Song> _filteredSongs = [];

  @override
  void initState() {
    super.initState();
    _songService.songsStream.listen((List<Song> songs) {
      setState(() {
        _songs = songs;
        _songs.sort((a, b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        _onSearchChanged(_searchController
            .text); // Update filtered songs when the original list changes
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (query) => _onSearchChanged(query),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredSongs.length,
            itemBuilder: (BuildContext context, int index) {
              final song = _filteredSongs[index];

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
          ),
        ),
      ],
    );
  }

  void _onSearchChanged(String query) {
    setState(() {
      _filteredSongs = _songs
          .where((song) =>
              song.name.toLowerCase().contains(query.toLowerCase()) ||
              song.artist.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
