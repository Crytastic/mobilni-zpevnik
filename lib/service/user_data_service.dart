import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobilni_zpevnik/models/user_data.dart';
import 'package:rxdart/rxdart.dart';

class UserDataService {
  final _userDataCollection =
      FirebaseFirestore.instance.collection('users').withConverter(
    fromFirestore: (snapshot, options) {
      final json = snapshot.data() ?? {};
      json['id'] = snapshot.id;
      return UserData.fromJson(json);
    },
    toFirestore: (value, options) {
      final json = value.toJson();
      json.remove('id');
      return json;
    },
  );

  Stream<List<UserData>> get userDataStream =>
      _userDataCollection.snapshots().map((querySnapshot) =>
          querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());

  Stream<UserData?> get currentUserUserDataStream {
    return FirebaseAuth.instance.authStateChanges().switchMap((user) {
      if (user != null) {
        String currentUserId = user.uid;
        return userDataStream.map((List<UserData> users) {
          UserData? currentUser = users.firstWhere(
            (userData) => userData.id == currentUserId,
          );
          return currentUser;
        });
      } else {
        return Stream.value(null);
      }
    });
  }

  Future<bool> userDataExists(String userId) async {
    final userDataSnapshot = await _userDataCollection.doc(userId).get();
    return userDataSnapshot.exists;
  }

  Future<void> addToLatestSongs(String userId, Song song) async {
    final userDocRef = _userDataCollection.doc(userId);

    return FirebaseFirestore.instance.runTransaction((transaction) async {
      final userSnapshot = await transaction.get(userDocRef);
      if (userSnapshot.exists) {
        final userData = userSnapshot.data() as Map<String, dynamic>;
        final user = UserData.fromJson(userData);

        user.latestSongs.add(song);

        transaction.update(userDocRef, user.toJson());
      }
    });
  }
}
