// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songbook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Songbook _$SongbookFromJson(Map<String, dynamic> json) => Songbook(
      id: json['id'] as String?,
      ownerId: json['ownerId'] as String?,
      name: json['name'] as String,
      songs: (json['songs'] as List<dynamic>)
          .map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SongbookToJson(Songbook instance) => <String, dynamic>{
      'id': instance.id,
      'ownerId': instance.ownerId,
      'name': instance.name,
      'songs': instance.songs,
    };
