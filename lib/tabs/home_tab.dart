import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/service/song_service.dart';
import 'package:mobilni_zpevnik/service/user_data_service.dart';
import 'package:mobilni_zpevnik/utils/shared_ui_constants.dart';
import 'package:mobilni_zpevnik/widgets/handling_stream_builder.dart';
import 'package:mobilni_zpevnik/widgets/song_list.dart';
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
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildLastPlayed(),
          _buildRecommended(),
        ],
      ),
    );
  }

  Widget _buildLastPlayed() {
    return HandlingStreamBuilder<List<Song>>(
      stream: _userDataService.latestSongsStream,
      builder: (context, latestSongs) {
        if (latestSongs.isEmpty) {
          return Container();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('last-played'.i18n()),
            _buildLastPlayedSection(latestSongs),
          ],
        );
      },
    );
  }

  Widget _buildRecommended() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('recommended'.i18n()),
        _buildRecommendedSection(),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(SMALL_GAP),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: STANDARD_FONT_SIZE,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLastPlayedSection(List<Song> lastPlayed) {
    return SongList(songs: lastPlayed);
  }

  Widget _buildRecommendedSection() {
    return HandlingStreamBuilder<List<Song>>(
      stream: _songService.songsStream,
      builder: (context, songs) {
        return SongList(songs: songs);
      },
    );
  }
}
