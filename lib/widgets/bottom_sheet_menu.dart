import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/screens/add_to_songbook_screen.dart';

class BottomSheetMenu extends StatelessWidget {
  final Song song;
  final bool canAddToSongbook;
  final bool canRemoveFromSongbook;
  final VoidCallback? onAddToSongbookTap;
  final Function(Song song)? onRemoveFromSongbookTap;

  const BottomSheetMenu({
    Key? key,
    required this.song,
    this.canAddToSongbook = true,
    this.canRemoveFromSongbook = false,
    this.onAddToSongbookTap,
    this.onRemoveFromSongbookTap,
  }) : super(key: key);

  static void show(
    BuildContext context,
    Song song, {
    bool canAddToSongbook = false,
    bool canRemoveFromSongbook = false,
    VoidCallback? onAddToSongbookTap,
    Function(Song song)? onRemoveFromSongbookTap,
  }) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return BottomSheetMenu(
          song: song,
          canAddToSongbook: canAddToSongbook,
          canRemoveFromSongbook: canRemoveFromSongbook,
          onAddToSongbookTap: onAddToSongbookTap,
          onRemoveFromSongbookTap: onRemoveFromSongbookTap,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 8.0),
        _buildSwipeIndicator(),
        ListTile(
          title: Text(song.name),
          subtitle: Text(song.artist),
        ),
        const Divider(height: 1),
        if (canAddToSongbook)
          ListTile(
            leading: const Icon(Icons.add_circle_rounded),
            title: Text('add-to-songbook'.i18n()),
            onTap: onAddToSongbookTap,
          ),
        if (canRemoveFromSongbook)
          ListTile(
            leading: const Icon(Icons.remove_circle_rounded),
            title: Text('remove-from-songbook'.i18n()),
            onTap: onRemoveFromSongbookTap != null
                ? () => onRemoveFromSongbookTap!(song)
                : null,
          ),
      ],
    );
  }

  Widget _buildSwipeIndicator() {
    return Container(
      width: 40.0,
      height: 4.0,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }
}
