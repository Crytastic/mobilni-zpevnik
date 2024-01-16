import 'package:flutter/material.dart';

class CommonTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CommonTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).focusColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
