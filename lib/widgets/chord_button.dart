import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/models/chord.dart';
import 'package:mobilni_zpevnik/utils/shared_ui_constants.dart';
import 'package:provider/provider.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:mobilni_zpevnik/utils/preferences_provider.dart';

class ChordButton extends StatelessWidget {
  final String chord;
  final _controller = SuperTooltipController();
  final bool down;

  ChordButton({super.key, required this.chord, required this.down});

  Future<bool> _willPopCallback() async {
    // If the tooltip is open we don't pop the page on a backbutton press
    // but close the ToolTip
    if (_controller.isVisible) {
      await _controller.hideTooltip();
      return false;
    }
    return true;
  }

  @override
  build(BuildContext context) {
    final bool darkTheme = Theme.of(context).brightness == Brightness.dark;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    TooltipDirection tooltipDirection =
        down ? TooltipDirection.down : TooltipDirection.up;
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

    return WillPopScope(
      onWillPop: _willPopCallback,
      child: TapRegion(
        onTapOutside: (event) async {
          await _controller.hideTooltip();
        },
        child: SuperTooltip(
          controller: _controller,
          showBarrier: false,
          constraints: const BoxConstraints(
            maxWidth: 80,
            maxHeight: 120,
            minWidth: 80,
            minHeight: 120,
          ),
          popupDirection: tooltipDirection,
          hideTooltipOnTap: true,
          minimumOutsideMargin: 10,
          content: Image(
            width: 80,
            height: 120,
            image: Chord(name: chord).getImage(darkTheme),
          ),
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
        ),
      ),
    );
  }
}
