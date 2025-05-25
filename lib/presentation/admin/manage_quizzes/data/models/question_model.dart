// lib/features/admin/manage_quizzes/data/models/question_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/entities/question.dart';

part 'question_model.freezed.dart';
part 'question_model.g.dart';

@freezed
abstract class QuestionModel with _$QuestionModel {
  const QuestionModel._(); // Enables custom methods like toEntity

  const factory QuestionModel({
    required String question,
    required List<String> options,
    required String answer,
  }) = _QuestionModel;

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  Question toEntity() => Question(
        question: question,
        options: options,
        answer: answer,
      );

  factory QuestionModel.fromEntity(Question entity) => QuestionModel(
        question: entity.question,
        options: entity.options,
        answer: entity.answer,
      );
}
