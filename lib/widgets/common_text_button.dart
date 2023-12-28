import 'package:flutter/material.dart';

class CommonTextButton extends StatelessWidget {
  final text;
  final onPressed;

  const CommonTextButton({
    super.key,
    this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
