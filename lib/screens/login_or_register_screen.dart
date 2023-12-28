import 'package:flutter/cupertino.dart';
import 'package:mobilni_zpevnik/screens/register_screen.dart';
import 'package:mobilni_zpevnik/screens/login_screen.dart';

class LoginOrRegisterScreen extends StatefulWidget {
  const LoginOrRegisterScreen({super.key});

  @override
  State<LoginOrRegisterScreen> createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends State<LoginOrRegisterScreen> {
  bool showLoginScreen = true;

  void toggleScreen() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLoginScreen
        ? LoginScreen(swapForRegisterScreen: toggleScreen)
        : RegisterScreen(swapForLoginScreen: toggleScreen);
  }
}
