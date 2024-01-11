import 'package:json_annotation/json_annotation.dart';
import 'package:mobilni_zpevnik/models/song.dart';

part 'songbook.g.dart';

@JsonSerializable()
class Songbook {
  final String? id;
  final String? ownerId;
  final String name;
  final List<Song> songs;

  const Songbook({
    this.id,
    required this.ownerId,
    required this.name,
    required this.songs,
  });

  factory Songbook.fromJson(Map<String, dynamic> json) =>
      _$SongbookFromJson(json);

  Map<String, dynamic> toJson() => _$SongbookToJson(this);
}
