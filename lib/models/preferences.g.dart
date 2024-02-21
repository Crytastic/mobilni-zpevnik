// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Preferences _$PreferencesFromJson(Map<String, dynamic> json) => Preferences(
      showChords: json['showChords'] as bool? ?? true,
      showHAsB: json['showHAsB'] as bool? ?? false,
      showMiAsM: json['showMiAsM'] as bool? ?? false,
      themeMode: $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
          ThemeMode.system,
      fontFamily: json['fontFamily'] as String? ?? 'Roboto',
    );

Map<String, dynamic> _$PreferencesToJson(Preferences instance) =>
    <String, dynamic>{
      'showChords': instance.showChords,
      'showHAsB': instance.showHAsB,
      'showMiAsM': instance.showMiAsM,
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'fontFamily': instance.fontFamily,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
