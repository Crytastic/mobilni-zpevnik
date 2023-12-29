import 'package:flutter/cupertino.dart';
import 'package:mobilni_zpevnik/widgets/songbook_tile.dart';
import 'package:mobilni_zpevnik/models/songbook.dart';

class SongbookList extends StatelessWidget {
  final List<Songbook> songbooks;

  const SongbookList({super.key, required this.songbooks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: songbooks.length,
      itemBuilder: (BuildContext context, int index) {
        return SongbookTile(
          songbook: songbooks[index],
          index: index,
        );
      },
    );
  }
}
