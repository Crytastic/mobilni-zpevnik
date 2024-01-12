import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/utils/queue_set.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData {
  String id;
  QueueSet<Song> latestSongs;

  UserData({
    required this.id,
    required this.latestSongs,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
