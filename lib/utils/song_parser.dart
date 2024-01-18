import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/utils/preferences_provider.dart';
import 'package:mobilni_zpevnik/utils/shared_ui_constants.dart';
import 'package:mobilni_zpevnik/widgets/chord_button.dart';
import 'package:provider/provider.dart';

class SongParser extends StatelessWidget {
  final String songContent;

  const SongParser({super.key, required this.songContent});

  @override
  Widget build(BuildContext context) {
    final preferencesProvider =
        Provider.of<PreferencesProvider>(context, listen: true);

    return parseLyrics(preferencesProvider.preferences.showChords);
  }

  bool _isEmptyLine(String line) {
    return line.trim().isEmpty;
  }

  bool _isChordLine(String line) {
    if (line.trim().isEmpty) {
      return false;
    }

    const String notes = '[CDEFGABH]';
    const String accidentals = '(b|bb)?';
    const String chords = '(m|mi|maj7|maj|min7|min|sus)?';
    const String suspends = '(1|2|3|4|5|6|7|8|9)?';
    const String sharp = '(#)?';
    const String chordPattern =
        notes + accidentals + chords + suspends + sharp + r'\b';
    RegExp chordRegex = RegExp(chordPattern);

    List<String?> words =
        RegExp(r'\S+').allMatches(line).map((match) => match.group(0)).toList();
    return words.every((word) => chordRegex.hasMatch(word!));
  }

  List<String> _splitWordsAndSpaces(String input) {
    RegExp pattern = RegExp(r'(\S+|\s+)');
    return pattern.allMatches(input).map((match) => match.group(0)!).toList();
  }

  List<Widget> _parseChordLine(String line, bool down) {
    return _splitWordsAndSpaces(line)
        .map((String part) => part.contains(RegExp(r'\S'))
            ? ChordButton(chord: part, down: down)
            : Text(part))
        .toList();
  }

  Widget parseLyrics(bool showChords) {
    final List<String> lines = songContent.split('\\n');
    final List<Widget> columnWidgets = [];

    for (String line in lines) {
      if (_isEmptyLine(line)) {
        // This line is empty, i.e. just a new line
        columnWidgets.add(
          const SizedBox(height: NEWLINE_GAP),
        );
      } else if (_isChordLine(line) && showChords) {
        // This line contains chords, render them in grey boxes
        columnWidgets.add(
          Row(
            children: _parseChordLine(line, columnWidgets.length < 5),
          ),
        );
      } else if (!_isChordLine(line)) {
        // This line is just lyrics, render them as text
        columnWidgets.add(
          AutoSizeText(
            line,
            style: const TextStyle(fontSize: STANDARD_FONT_SIZE),
            maxLines: 1,
          ),
        );
      }

      // Add spacing between lines
      columnWidgets.add(const SizedBox(height: 2.0));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: columnWidgets,
    );
  }
}
