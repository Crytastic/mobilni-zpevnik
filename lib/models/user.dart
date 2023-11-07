class User {
  String id;
  String username;
  String email;
  String preferences;
  List<String> songbooks;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.preferences,
    required this.songbooks,
  });
}
