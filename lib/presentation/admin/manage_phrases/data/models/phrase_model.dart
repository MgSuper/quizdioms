import 'package:json_annotation/json_annotation.dart';

part 'phrase_model.g.dart';

@JsonSerializable()
class PhraseModel {
  @JsonKey(defaultValue: '')
  final String phrase;

  @JsonKey(defaultValue: '')
  final String meaning;

  @JsonKey(defaultValue: '')
  final String example1;

  @JsonKey(defaultValue: '')
  final String example2;

  PhraseModel({
    required this.phrase,
    required this.meaning,
    required this.example1,
    required this.example2,
  });

  factory PhraseModel.fromJson(Map<String, dynamic> json) =>
      _$PhraseModelFromJson(json);
  Map<String, dynamic> toJson() => _$PhraseModelToJson(this);
}
