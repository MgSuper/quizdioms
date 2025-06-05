import 'package:json_annotation/json_annotation.dart';
import 'package:quizdioms/core/utils/shared.dart';
import 'phrase_model.dart';

part 'phrase_group_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PhraseGroupModel {
  final String? id;

  @JsonKey(name: 'group_name', defaultValue: '')
  final String groupName;

  @JsonKey(name: 'created_at')
  @DateTimeTimestampConverter()
  final DateTime createdAt;

  @JsonKey(defaultValue: [])
  final List<PhraseModel> phrases;

  PhraseGroupModel({
    this.id,
    required this.groupName,
    required this.createdAt,
    required this.phrases,
  });

  factory PhraseGroupModel.fromJson(Map<String, dynamic> json) =>
      _$PhraseGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhraseGroupModelToJson(this);
}
