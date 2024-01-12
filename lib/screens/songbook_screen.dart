import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/screens/screen_template.dart';
import 'package:mobilni_zpevnik/widgets/menu_option.dart';
import 'package:mobilni_zpevnik/widgets/song_list.dart';
import 'package:mobilni_zpevnik/models/songbook.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/service/songbook_service.dart';
import 'package:mobilni_zpevnik/widgets/bottom_sheet_menu.dart';
import 'package:mobilni_zpevnik/widgets/ui_gaps.dart';
import 'package:mobilni_zpevnik/service/auth_service.dart';
import 'package:mobilni_zpevnik/widgets/handling_stream_builder.dart';
import 'package:mobilni_zpevnik/widgets/snack_notification.dart';

import '../utils/shared_ui_constants.dart';

class SongbookScreen extends StatelessWidget {
  final Songbook songbook;
  final _songbookService = GetIt.I<SongbookService>();
  final _authService = GetIt.I<AuthService>();

  SongbookScreen({super.key, required this.songbook});

  void _removeSongFromSongbook(Song song) {
    _songbookService.removeSongFromSongbook(songbook.id, song.id);
  }

  void _removeSongbook(Songbook songbook) {
    _songbookService.deleteSongbook(songbook.id);
  }

  @override
  Widget build(BuildContext context) {
    return HandlingStreamBuilder<Songbook>(
      stream: _songbookService.singleSongbookStream(songbook.id),
      builder: (context, updatedSongbook) {
        return ScreenTemplate(
          appBar: AppBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSongbookHeader(context, updatedSongbook),
              const Divider(height: 1),
              _buildSongbookListOfSongs(context, updatedSongbook),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSongbookHeader(BuildContext context, Songbook songbook) {
    List<MenuOption> menuOptions = [
      MenuOption(
        icon: Icons.delete_rounded,
        title: 'delete-songbook'.i18n(),
        onTap: () {
          _removeSongbook(songbook);
          Navigator.popUntil(context, (route) => route.isFirst);
          SnackNotification.show(
            context,
            'Deleted ${songbook.name}',
          );
        },
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SMALL_GAP),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SmallGap(),
              _buildSongbookName(songbook),
              const SmallGap(),
              _buildUserName(),
              const SmallGap(),
              _buildNumberOfSongs(songbook),
              const SmallGap(),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              BottomSheetMenu.show(
                context,
                ListTile(
                  title: Text(songbook.name),
                  subtitle: Text(_authService.userDisplayName),
                ),
                menuOptions,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNumberOfSongs(Songbook songbook) {
    return Text(
      '${'number-of-songs'.i18n()}: ${songbook.songs.length}',
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildUserName() {
    return Row(
      children: [
        const Icon(Icons.account_circle_rounded),
        const SmallGap(),
        Text(_authService.userDisplayName),
      ],
    );
  }

  Widget _buildSongbookName(Songbook songbook) {
    return Text(
      songbook.name,
      style: const TextStyle(
        fontSize: STANDARD_FONT_SIZE,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSongbookListOfSongs(BuildContext context, Songbook songbook) {
    return Expanded(
      child: _buildSongList(context, songbook),
    );
  }

  Widget _buildSongList(BuildContext context, Songbook songbook) {
    songbook.songs.sort((a, b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });

    if (songbook.songs.isEmpty) {
      return Center(child: Text('no-songs'.i18n()));
    }

    return SongList(
      songs: songbook.songs,
      canRemoveFromSongbook: true,
      onRemoveFromSongbookTap: (Song song) {
        _removeSongFromSongbook(song);
        Navigator.pop(context);
        SnackNotification.show(
          context,
          'Removed ${song.name} from ${songbook.name}',
        );
      },
    );
  }
}
