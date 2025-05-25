// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'idioms.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Idiom _$IdiomFromJson(Map<String, dynamic> json) => _Idiom(
      text: json['text'] as String,
      meaning: json['meaning'] as String,
      usage: json['usage'] as String,
    );

Map<String, dynamic> _$IdiomToJson(_Idiom instance) => <String, dynamic>{
      'text': instance.text,
      'meaning': instance.meaning,
      'usage': instance.usage,
    };

_IdiomGroup _$IdiomGroupFromJson(Map<String, dynamic> json) => _IdiomGroup(
      id: json['id'] as String,
      idioms: (json['idioms'] as List<dynamic>)
          .map((e) => Idiom.fromJson(e as Map<String, dynamic>))
          .toList(),
      groupName: json['groupName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$IdiomGroupToJson(_IdiomGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idioms': instance.idioms,
      'groupName': instance.groupName,
      'createdAt': instance.createdAt.toIso8601String(),
    };
