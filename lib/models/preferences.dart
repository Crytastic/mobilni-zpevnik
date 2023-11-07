class Preferences {
  String id;
  bool darkmode;
  String mainInstrument;
  bool showChords;
  bool simplifiedChords;
  bool showBAsH;
  bool showMiAsM;
  String language;

  Preferences({
    required this.id,
    required this.darkmode,
    required this.mainInstrument,
    required this.showChords,
    required this.simplifiedChords,
    required this.showBAsH,
    required this.showMiAsM,
    required this.language,
  });
}
