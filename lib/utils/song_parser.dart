import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/widgets/chord_button.dart';

class SongParser extends StatelessWidget {
  final String songContent;

  const SongParser({super.key, required this.songContent});

  @override
  Widget build(BuildContext context) {
    return parseLyrics();
  }

  bool _isChordLine(String line) {
    const String notes = '[CDEFGAB]';
    const String accidentals = '(b|bb)?';
    const String chords = '(m|mi|maj7|maj|min7|min|sus)?';
    const String suspends = '(1|2|3|4|5|6|7|8|9)?';
    const String sharp = '(#)?';
    const String chordPattern =
        notes + accidentals + chords + suspends + sharp + r'\b';
    RegExp chordRegex = RegExp(chordPattern);

    return chordRegex.hasMatch(line);
  }

  List<String> _splitWordsAndSpaces(String input) {
    RegExp pattern = RegExp(r'(\S+|\s+)');
    return pattern.allMatches(input).map((match) => match.group(0)!).toList();
  }

  List<Widget> _parseChordLine(String line) {
    return _splitWordsAndSpaces(line)
        .map((String part) => part.contains(RegExp(r'\S'))
            ? ChordButton(chord: part)
            : Text(part))
        .toList();
  }

  Widget parseLyrics() {
    final List<String> lines = songContent.split("\\n");
    final List<Widget> columnWidgets = [];
    const bool showChords = true;

    for (String line in lines) {
      if (_isChordLine(line) && showChords) {
        // This line contains chords, render them in grey boxes
        columnWidgets.add(
          Row(
            children: _parseChordLine(line),
          ),
        );
      } else if (!_isChordLine(line)) {
        // This line is just lyrics, render them as text
        columnWidgets.add(Text(line));
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
