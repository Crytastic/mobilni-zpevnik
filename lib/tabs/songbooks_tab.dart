import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/widgets/songbook_list.dart';
import 'package:mobilni_zpevnik/models/songbook.dart';
import 'package:mobilni_zpevnik/widgets/songbooks_stream_builder.dart';

class SongbooksTab extends StatelessWidget {
  const SongbooksTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SongbooksStreamBuilder(
      builder: (BuildContext context, List<Songbook> songbooks) {
        return SongbookList(songbooks: songbooks);
      },
    );
  }
}
