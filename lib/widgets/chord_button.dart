import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/models/chord.dart';
import 'package:mobilni_zpevnik/utils/shared_ui_constants.dart';
import 'package:provider/provider.dart';
import 'package:mobilni_zpevnik/utils/preferences_provider.dart';

class ChordButton extends StatelessWidget {
  final String chord;

  const ChordButton({super.key, required this.chord});

  @override
  build(BuildContext context) {
    final bool darkTheme = Theme.of(context).brightness == Brightness.dark;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final preferencesProvider =
        Provider.of<PreferencesProvider>(context, listen: true);

    String formattedChord() {
      String formattedChord = chord;
      if (preferencesProvider.preferences.showHAsB) {
        formattedChord = formattedChord.replaceAll('H', 'B');
      }

      if (preferencesProvider.preferences.showMiAsM) {
        formattedChord = formattedChord.replaceAll('mi', 'm');
      }

      return formattedChord;
    }

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(STANDARD_RADIUS),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(BIG_GAP),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image(
                        width: 80,
                        height: 120,
                        image: Chord(name: chord).getImage(darkTheme),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 5.0,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(SMALL_RADIUS),
        ),
        child: Text(
          formattedChord(),
          style: TextStyle(
            fontSize: STANDARD_FONT_SIZE,
            color: colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
