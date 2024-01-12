import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/utils/shared_ui_constants.dart';

class Gap extends StatelessWidget {
  const Gap({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: STANDARD_GAP,
    );
  }
}

class SmallGap extends StatelessWidget {
  const SmallGap({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: SMALL_GAP,
      width: SMALL_GAP,
    );
  }
}
