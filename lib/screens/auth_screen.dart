import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobilni_zpevnik/screens/login_or_register_screen.dart';
import 'package:mobilni_zpevnik/service/auth_service.dart';
import 'package:mobilni_zpevnik/widgets/handling_stream_builder.dart';

class AuthScreen extends StatelessWidget {
  final Widget child;
  final _authService = GetIt.I<AuthService>();

  AuthScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return HandlingStreamBuilder<User?>(
      stream: _authService.userStream,
      builder: (context, user) {
        if (user != null) {
          return child;
        } else {
          return const LoginOrRegisterScreen();
        }
      },
    );
  }
}
