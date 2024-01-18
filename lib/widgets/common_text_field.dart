import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/utils/shared_ui_constants.dart';

class CommonTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final bool autofocus;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;
  final String? errorText;

  const CommonTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.autofocus = false,
    this.prefixIcon,
    this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        errorText: errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(STANDARD_RADIUS),
        ),
      ),
      onChanged: onChanged,
      autofocus: autofocus,
    );
  }
}
