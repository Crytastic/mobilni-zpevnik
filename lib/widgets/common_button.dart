import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/utils/shared_ui_constants.dart';

class CommonButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double height;
  final double width;

  const CommonButton({
    super.key,
    this.height = 50.0,
    this.width = double.infinity,
    this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(STANDARD_RADIUS),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
