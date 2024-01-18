// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Preferences _$PreferencesFromJson(Map<String, dynamic> json) => Preferences(
      showChords: json['showChords'] as bool? ?? true,
      showHAsB: json['showHAsB'] as bool? ?? false,
      showMiAsM: json['showMiAsM'] as bool? ?? false,
    );

Map<String, dynamic> _$PreferencesToJson(Preferences instance) =>
    <String, dynamic>{
      'showChords': instance.showChords,
      'showHAsB': instance.showHAsB,
      'showMiAsM': instance.showMiAsM,
    };
