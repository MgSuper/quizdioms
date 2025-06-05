// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phrase_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhraseGroupModel _$PhraseGroupModelFromJson(Map<String, dynamic> json) =>
    PhraseGroupModel(
      id: json['id'] as String?,
      groupName: json['group_name'] as String? ?? '',
      createdAt:
          const DateTimeTimestampConverter().fromJson(json['created_at']),
      phrases: (json['phrases'] as List<dynamic>?)
              ?.map((e) => PhraseModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PhraseGroupModelToJson(PhraseGroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'group_name': instance.groupName,
      'created_at':
          const DateTimeTimestampConverter().toJson(instance.createdAt),
      'phrases': instance.phrases.map((e) => e.toJson()).toList(),
    };
