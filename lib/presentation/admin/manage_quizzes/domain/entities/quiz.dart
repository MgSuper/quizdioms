import 'package:freezed_annotation/freezed_annotation.dart';
import 'question.dart';

part 'quiz.freezed.dart';
part 'quiz.g.dart';

@freezed
abstract class Quiz with _$Quiz {
  const factory Quiz({
    required String id,
    required String title,
    required List<Question> questions,
  }) = _Quiz;

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
}
