import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class CommonTextButton extends StatelessWidget {
  final text;
  final route;

  const CommonTextButton({
    super.key,
    this.text,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => route,
          ),
        );
      },
    );
  }
}
