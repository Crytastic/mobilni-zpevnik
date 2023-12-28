import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/screens/login_or_register_screen.dart';

class AuthScreen extends StatelessWidget {
  final Widget child;

  const AuthScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return child;
        } else {
          return const LoginOrRegisterScreen();
        }
      },
    );
  }
}
