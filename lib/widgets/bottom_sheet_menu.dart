import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'gap.dart';

class BottomSheetMenu extends StatelessWidget {
  final Song song;
  final Function(String) onOptionSelected;

  const BottomSheetMenu({
    Key? key,
    required this.onOptionSelected,
    required this.song,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
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
              Navigator.pop(context);
            },
          ),
        ],
      ),
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
