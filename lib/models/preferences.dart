import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'preferences.g.dart';

@JsonSerializable()
class Preferences {
  bool showChords;
  bool showHAsB;
  bool showMiAsM;
  ThemeMode themeMode;

  Preferences({
    this.showChords = true,
    this.showHAsB = false,
    this.showMiAsM = false,
    this.themeMode = ThemeMode.system,
  });

  factory Preferences.fromJson(Map<String, dynamic> json) =>
      _$PreferencesFromJson(json);

  Map<String, dynamic> toJson() => _$PreferencesToJson(this);
}
