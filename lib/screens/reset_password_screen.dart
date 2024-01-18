import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/screens/login_error_notifier.dart';
import 'package:mobilni_zpevnik/screens/screen_template.dart';
import 'package:mobilni_zpevnik/widgets/common_text_field.dart';
import 'package:mobilni_zpevnik/widgets/common_button.dart';
import 'package:mobilni_zpevnik/widgets/snack_notification.dart';
import 'package:provider/provider.dart';
import 'package:mobilni_zpevnik/widgets/ui_gaps.dart';
import 'package:mobilni_zpevnik/widgets/progress_indicator.dart';
import 'package:mobilni_zpevnik/service/auth_service.dart';
import 'package:mobilni_zpevnik/utils/shared_ui_constants.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;
  late final emailController = TextEditingController(text: email);
  final _authService = GetIt.I<AuthService>();

  ResetPasswordScreen({super.key, required this.email});

  Future _resetPassword(
      BuildContext context, LoginErrorProvider loginErrorProvider) async {
    loginErrorProvider.clearEmailErrorMessage();
    ProgressDialog.show(context);

    try {
      await _authService.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      if (context.mounted) {
        SnackNotification.show(context, 'password-reset-email'.i18n());
      }
    } on FirebaseAuthException catch (e) {
      final String code = e.code;
      switch (code) {
        case 'invalid-email':
          loginErrorProvider.setEmailErrorMessage(code.i18n());
          break;
        default:
          loginErrorProvider.setEmailErrorMessage(code.i18n());
          break;
      }
    }

    if (context.mounted) {
      ProgressDialog.hide(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginErrorProvider =
        Provider.of<LoginErrorProvider>(context, listen: true);

    return ScreenTemplate(
      appBar: AppBar(
        title: Text('reset-password'.i18n()),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SMALL_GAP),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const BigGap(),
              CommonTextField(
                controller: emailController,
                hintText: 'e-mail'.i18n(),
                obscureText: false,
                errorText: loginErrorProvider.emailErrorMessage,
              ),
              const BigGap(),
              CommonButton(
                onPressed: () {
                  _resetPassword(context, loginErrorProvider);
                },
                label: 'reset-password'.i18n(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
