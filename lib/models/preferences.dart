import 'package:json_annotation/json_annotation.dart';

part 'preferences.g.dart';

@JsonSerializable()
class Preferences {
  bool showChords;
  bool showHAsB;
  bool showMiAsM;

  Preferences({
    this.showChords = true,
    this.showHAsB = false,
    this.showMiAsM = false,
  });

  factory Preferences.fromJson(Map<String, dynamic> json) =>
      _$PreferencesFromJson(json);

  Map<String, dynamic> toJson() => _$PreferencesToJson(this);
}
