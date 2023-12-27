import 'package:flutter/material.dart';

class CommonSquareButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String imagePath;

  const CommonSquareButton({super.key, this.onPressed, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: colorScheme.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.asset(
        imagePath,
        height: 50,
      ),
    );
  }
}
