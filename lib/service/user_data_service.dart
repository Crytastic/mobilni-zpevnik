import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobilni_zpevnik/models/user_data.dart';
import 'package:mobilni_zpevnik/utils/queue_set.dart';
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
          UserData? currentUser = users.firstWhereOrNull(
            (userData) => userData.id == currentUserId,
          );
          return currentUser;
        });
      } else {
        return Stream.value(null);
      }
    });
  }

  /// Get UserData DocumentReference.
  ///
  /// If it doesn't exist yet, create it and then return it.
  /// UserData in Firestore 'users' with same UID as FirebaseAuth user
  Future<DocumentReference<UserData>?> _getUserData() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      if (kDebugMode) {
        print('User not signed in');
      }
      return null;
    }

    if (await userDataExists(userId)) {
      // UserData already exists, return its DocumentReference
      return _userDataCollection.doc(userId);
    }

    if (kDebugMode) {
      print('Creating new UserData for user ID $userId');
    }

    final newUserData = UserData(id: userId, latestSongs: []);
    final customDocRef = _userDataCollection.doc(userId);
    await customDocRef.set(newUserData);

    return customDocRef;
  }

  Future<void> deleteUserData(String userId) {
    return _userDataCollection.doc(userId).delete();
  }

  Future<bool> userDataExists(String userId) async {
    final userDataSnapshot = await _userDataCollection.doc(userId).get();
    return userDataSnapshot.exists;
  }

  Future<void> addToLatestSongs(Song song) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      if (kDebugMode) {
        print('User not signed in');
      }
      return;
    }

    // Ensure UserData exists, and get its DocumentReference
    final userDataReference = await _getUserData();
    if (userDataReference == null) {
      // UserData creation failed or user not signed in
      return;
    }

    final userDataSnapshot = await userDataReference.get();
    final existingLatestSongs =
        List<Map<String, dynamic>>.from(userDataSnapshot['latestSongs']);

    existingLatestSongs.add(song.toJson());
    await userDataReference.update({'latestSongs': existingLatestSongs});
  }
}
