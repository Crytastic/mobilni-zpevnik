import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/models/chord.dart';
import 'package:super_tooltip/super_tooltip.dart';

class ChordButton extends StatelessWidget {
  final String chord;
  const ChordButton({Key? key, required this.chord}) : super(key: key);

  @override
  build(BuildContext context) {
    final bool darkTheme = Theme.of(context).brightness == Brightness.dark;
    return SuperTooltip(
        popupDirection: TooltipDirection.up,
        showBarrier: false,
        hideTooltipOnTap: true,
        content:
            Image(width: 80, image: Chord(name: chord).getImage(darkTheme)),
        child: Container(
          padding: const EdgeInsets.all(2.0),
          color: Colors.white12,
          child: Text(
            chord,
            style: TextStyle(color: (darkTheme ? Colors.white : Colors.black)),
          ),
        ));
  }
}
