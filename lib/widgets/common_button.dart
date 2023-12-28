import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double height;
  final double width;

  const CommonButton({
    Key? key,
    this.height = 50.0,
    this.width = double.infinity,
    this.onPressed,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.background,
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
