import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/screens/screen_template.dart';
import 'package:mobilni_zpevnik/utils/auto_scroll_provider.dart';
import 'package:mobilni_zpevnik/utils/song_parser.dart';
import 'package:provider/provider.dart';
import 'package:mobilni_zpevnik/utils/shared_ui_constants.dart';
import 'package:mobilni_zpevnik/widgets/ui_gaps.dart';
import 'package:mobilni_zpevnik/widgets/preferences_button.dart';

import '../widgets/bottom_sheet_menu.dart';
import '../widgets/menu_option.dart';
import '../widgets/song_trailing_button.dart';

class SongScreen extends StatelessWidget {
  final Song song;
  final List<MenuOption> songMenuOptions;

  const SongScreen({
    super.key,
    required this.song,
    required this.songMenuOptions,
  });

  @override
  Widget build(BuildContext context) {
    final autoScrollProvider =
        Provider.of<AutoScrollProvider>(context, listen: true);

    FloatingActionButton buildScrollingButton() {
      return FloatingActionButton(
        heroTag: "toggleAutoScroll",
        onPressed: autoScrollProvider.toggleAutoScroll,
        child: Icon(
          autoScrollProvider.isScrolling
              ? Icons.stop_rounded
              : Icons.arrow_downward_rounded,
        ),
      );
    }

    FloatingActionButton buildAutoScrollIncr(BuildContext context) {
      return FloatingActionButton(
        heroTag: "autoScrollIncr",
        onPressed: () {
          autoScrollProvider.increaseAutoScrollSpeed();
        },
        backgroundColor:
            Theme.of(context).colorScheme.primaryContainer.withOpacity(0.6),
        child: const Icon(Icons.fast_forward_rounded),
      );
    }

    FloatingActionButton buildAutoScrollDecr(BuildContext context) {
      return FloatingActionButton(
        heroTag: "autoScrollDecr",
        onPressed: () {
          autoScrollProvider.decreaseAutoScrollSpeed();
        },
        backgroundColor:
            Theme.of(context).colorScheme.primaryContainer.withOpacity(0.6),
        child: const Icon(Icons.fast_rewind_rounded),
      );
    }

    return ScreenTemplate(
      appBar: AppBar(
        title: Text(song.name),
        actions: <Widget>[
          SongTrailingButton(
            song: song,
            menuOptions: songMenuOptions,
          ),
        ],
      ),
      bottomBar: null,
      body: SingleChildScrollView(
        controller: autoScrollProvider.scrollController,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildArtistHeader(),
            const BigGap(),
            SongParser(songContent: song.content),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          buildAutoScrollIncr(context),
          const StandardGap(),
          buildAutoScrollDecr(context),
          const StandardGap(),
          buildScrollingButton(),
        ],
      ),
    );
  }

  Widget _buildArtistHeader() {
    return Text(
      '${'artist'.i18n()}: ${song.artist}',
      style: const TextStyle(
        fontSize: STANDARD_FONT_SIZE,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
