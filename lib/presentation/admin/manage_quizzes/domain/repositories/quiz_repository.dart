// lib/features/admin/manage_quizzes/domain/repositories/quiz_repository.dart

import 'package:quizdioms/presentation/admin/manage_quizzes/domain/entities/quiz.dart';

abstract class QuizRepository {
  Future<List<Quiz>> getAllQuizzes();
  Future<void> addQuiz(Quiz quiz);
  Future<void> updateQuiz(Quiz quiz);
  Future<void> deleteQuiz(String id);
}
