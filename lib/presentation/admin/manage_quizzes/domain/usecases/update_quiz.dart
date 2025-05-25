// lib/features/admin/manage_quizzes/domain/usecases/update_quiz.dart

import 'package:quizdioms/presentation/admin/manage_quizzes/domain/entities/quiz.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/repositories/quiz_repository.dart';

class UpdateQuiz {
  final QuizRepository repository;

  UpdateQuiz(this.repository);

  Future<void> call(Quiz quiz) async {
    await repository.updateQuiz(quiz);
  }
}
