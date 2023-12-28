import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/screens/add_to_songbook_screen.dart';

class BottomSheetMenu extends StatelessWidget {
  final Song song;

  const BottomSheetMenu({
    Key? key,
    required this.song,
  }) : super(key: key);

  static void show(BuildContext context, Song song) {
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
        ListTile(
          leading: const Icon(Icons.add_circle_rounded),
          title: Text('add-to-songbook'.i18n()),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddToSongbookScreen(song: song),
              ),
            );
          },
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
