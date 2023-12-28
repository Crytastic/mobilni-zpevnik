import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/models/songbook.dart';

class SongbookService {
  final _songbookCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('songbooks')
      .withConverter(
    fromFirestore: (snapshot, options) {
      final json = snapshot.data() ?? {};
      json['id'] = snapshot.id;
      return Songbook.fromJson(json);
    },
    toFirestore: (value, options) {
      final json = value.toJson();
      json.remove('id');
      return json;
    },
  );

  Stream<List<Songbook>> get songbooksStream =>
      _songbookCollection.snapshots().map((querySnapshot) =>
          querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());

  Future<void> createSongbook(Songbook songbook) {
    return _songbookCollection.add(songbook);
  }

  Future<void> addSongToSongbook(String songbookId, Song song) {
    final songbookRef = _songbookCollection.doc(songbookId);
    return FirebaseFirestore.instance.runTransaction((transaction) async {
      final songbookSnapshot = await transaction.get(songbookRef);
      if (songbookSnapshot.exists) {
        final currentSongs = List<Map<String, dynamic>>.from(
            songbookSnapshot.data()?.songs ?? []);
        currentSongs.add(song.toJson());
        transaction.update(songbookRef, {'songs': currentSongs});
      }
    });
  }

  Future<void> deleteSongbook(String songbookId) {
    return _songbookCollection.doc(songbookId).delete();
  }
}
