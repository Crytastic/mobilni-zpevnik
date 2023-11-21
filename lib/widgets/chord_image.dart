import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/models/chord.dart';

class ChordImage extends StatelessWidget {
  final String chord;
  const ChordImage({Key? key, required this.chord}) : super(key: key);

  @override
  build(BuildContext context) {
    final bool darkTheme = Theme.of(context).brightness == Brightness.dark;
    return Image(width: 80, image: Chord(name: chord).getImage(darkTheme));
  }
}
