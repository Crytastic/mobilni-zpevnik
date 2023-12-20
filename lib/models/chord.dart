import 'package:flutter/material.dart';

class Chord {
  String name;

  Chord({
    required this.name,
  });

  String getChordName() {
    return name;
  }

  AssetImage getImage(bool darkTheme) {
    return AssetImage(
        'images/chords/${darkTheme ? "white" : "black"}/$name.png');
  }
}
