import 'package:flutter/material.dart';

class LoginErrorProvider extends ChangeNotifier {
  String? emailErrorMessage;
  String? passwordErrorMessage;

  void clearErrorMessages() {
    emailErrorMessage = null;
    passwordErrorMessage = null;
  }

  void setEmailErrorMessage(String message) {
    emailErrorMessage = message;
    notifyListeners();
  }

  void clearEmailErrorMessage() {
    emailErrorMessage = null;
    notifyListeners();
  }

  void setPasswordErrorMessage(String message) {
    passwordErrorMessage = message;
    notifyListeners();
  }

  void clearPasswordErrorMessage() {
    passwordErrorMessage = null;
    notifyListeners();
  }
}
