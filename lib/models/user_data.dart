import 'package:mobilni_zpevnik/models/preferences.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable(explicitToJson: true)
class UserData {
  String id;
  List<Song> latestSongs;
  Preferences preferences;

  UserData({
    required this.id,
    required this.latestSongs,
    required this.preferences,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
