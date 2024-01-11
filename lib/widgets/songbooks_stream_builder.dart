import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobilni_zpevnik/service/songbook_service.dart';
import 'package:mobilni_zpevnik/models/songbook.dart';

class SongbooksStreamBuilder extends StatelessWidget {
  final Widget Function(BuildContext, List<Songbook>) builder;

  const SongbooksStreamBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    final songbookService = GetIt.I<SongbookService>();

    return StreamBuilder<List<Songbook>>(
      stream: songbookService.currentUserSongbooksStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final songbooks = snapshot.data!;
        songbooks.sort((a, b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });

        return builder(context, songbooks);
      },
    );
  }
}
