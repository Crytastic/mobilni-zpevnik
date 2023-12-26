import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobilni_zpevnik/models/song.dart';

class SongService {
  final _songCollection =
      FirebaseFirestore.instance.collection('songs').withConverter(
    fromFirestore: (snapshot, options) {
      final json = snapshot.data() ?? {};
      json['id'] = snapshot.id;
      return Song.fromJson(json);
    },
    toFirestore: (value, options) {
      final json = value.toJson();
      json.remove('id');
      return json;
    },
  );

  Stream<List<Song>> get songsStream =>
      _songCollection.snapshots().map((querySnapshot) =>
          querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());

  Future<void> createSong(Song song) {
    return _songCollection.add(song);
  }

  Future<void> deleteSong(String songId) {
    return _songCollection.doc(songId).delete();
  }
}
