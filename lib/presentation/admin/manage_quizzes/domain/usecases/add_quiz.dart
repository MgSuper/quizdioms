// lib/features/admin/manage_quizzes/domain/usecases/add_quiz.dart

import 'package:quizdioms/presentation/admin/manage_quizzes/domain/entities/quiz.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/repositories/quiz_repository.dart';

class AddQuiz {
  final QuizRepository repository;

  AddQuiz(this.repository);

  Future<void> call(Quiz quiz) async {
    await repository.addQuiz(quiz);
  }
}
