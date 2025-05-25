import 'package:freezed_annotation/freezed_annotation.dart';

part 'question.freezed.dart';
part 'question.g.dart';

@freezed
abstract class Question with _$Question {
  const factory Question({
    required String question,
    required List<String> options,
    required String answer,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}
