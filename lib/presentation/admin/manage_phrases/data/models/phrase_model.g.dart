// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phrase_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhraseModel _$PhraseModelFromJson(Map<String, dynamic> json) => PhraseModel(
      phrase: json['phrase'] as String? ?? '',
      meaning: json['meaning'] as String? ?? '',
      example1: json['example1'] as String? ?? '',
      example2: json['example2'] as String? ?? '',
    );

Map<String, dynamic> _$PhraseModelToJson(PhraseModel instance) =>
    <String, dynamic>{
      'phrase': instance.phrase,
      'meaning': instance.meaning,
      'example1': instance.example1,
      'example2': instance.example2,
    };
