import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/utils/shared_ui_constants.dart';

class BigGap extends StatelessWidget {
  const BigGap({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: BIG_GAP,
    );
  }
}

class StandardGap extends StatelessWidget {
  const StandardGap({super.key});

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
