// lib/features/admin/manage_quizzes/domain/usecases/get_all_quizzes.dart

import 'package:quizdioms/presentation/admin/manage_quizzes/domain/entities/quiz.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/repositories/quiz_repository.dart';

class GetAllQuizzes {
  final QuizRepository repository;

  GetAllQuizzes(this.repository);

  Future<List<Quiz>> call() async {
    return await repository.getAllQuizzes();
  }
}
