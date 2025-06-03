// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuizModel _$QuizModelFromJson(Map<String, dynamic> json) => _QuizModel(
      id: json['id'] as String,
      title: json['title'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: const DateTimeTimestampConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$QuizModelToJson(_QuizModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'questions': instance.questions,
      'createdAt':
          const DateTimeTimestampConverter().toJson(instance.createdAt),
    };
