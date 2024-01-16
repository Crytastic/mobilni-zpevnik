import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/service/song_service.dart';
import 'package:mobilni_zpevnik/widgets/song_list.dart';
import 'package:mobilni_zpevnik/widgets/common_text_field.dart';
import 'package:mobilni_zpevnik/utils/shared_ui_constants.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

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
    return Column(
      children: [
        ColoredBox(
          color: Theme.of(context).colorScheme.background,
          child: _buildSearchBar(),
        ),
        Expanded(
          child: SongList(songs: _filteredSongs),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(SMALL_GAP),
      child: CommonTextField(
        controller: _searchController,
        hintText: 'search'.i18n(),
        prefixIcon: const Icon(Icons.search),
        onChanged: (query) => _onSearchChanged(query),
      ),
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
