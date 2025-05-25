// lib/features/admin/manage_quizzes/data/models/quiz_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/entities/quiz.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/data/models/question_model.dart';

part 'quiz_model.freezed.dart';
part 'quiz_model.g.dart';

@freezed
abstract class QuizModel with _$QuizModel {
  const QuizModel._(); // Enables custom methods like toEntity

  const factory QuizModel({
    required String id,
    required String title,
    required List<QuestionModel> questions,
  }) = _QuizModel;

  factory QuizModel.fromJson(Map<String, dynamic> json) =>
      _$QuizModelFromJson(json);

  Quiz toEntity() => Quiz(
        id: id,
        title: title,
        questions: questions.map((q) => q.toEntity()).toList(),
      );

  factory QuizModel.fromEntity(Quiz entity) => QuizModel(
        id: entity.id,
        title: entity.title,
        questions:
            entity.questions.map((q) => QuestionModel.fromEntity(q)).toList(),
      );
}
