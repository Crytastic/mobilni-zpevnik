class Song {
  String id;
  String name;
  String content;
  List<String> artists;
  List<String> albums;
  String bpm;
  String genre;
  String strumming;
  String communityRating;
  String key;
  String tuning;
  String capo;
  List<String> tags;

  Song({
    required this.id,
    required this.name,
    required this.content,
    required this.artists,
    required this.albums,
    required this.bpm,
    required this.genre,
    required this.strumming,
    required this.communityRating,
    required this.key,
    required this.tuning,
    required this.capo,
    required this.tags,
  });
}
