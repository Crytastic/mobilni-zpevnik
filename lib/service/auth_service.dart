import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth get instance => FirebaseAuth.instance;

  String get userDisplayName =>
      instance.currentUser?.displayName ??
      instance.currentUser?.email ??
      "Anonymous";

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    return await instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithEmail(String email, String password) async {
    return await instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signUpWithEmail(String email, String password) async {
    return await instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
