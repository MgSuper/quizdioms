// lib/features/admin/manage_quizzes/domain/usecases/delete_quiz.dart

import 'package:quizdioms/presentation/admin/manage_quizzes/domain/repositories/quiz_repository.dart';

class DeleteQuiz {
  final QuizRepository repository;

  DeleteQuiz(this.repository);

  Future<void> call(String id) async {
    await repository.deleteQuiz(id);
  }
}
