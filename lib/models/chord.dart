class Chord {
  String name;

  Chord({
    required this.name,
  }) {
    name = name.replaceAll("mi", 'm');
    name = name.replaceAll("H", 'B');
  }
}
