// lib/features/admin/manage_quizzes/data/repositories/quiz_repository_impl.dart

import 'package:quizdioms/presentation/admin/manage_quizzes/domain/entities/quiz.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/repositories/quiz_repository.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/data/datasources/quiz_remote_data_source.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/data/models/quiz_model.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizRemoteDataSource remoteDataSource;

  QuizRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Quiz>> getAllQuizzes() async {
    final quizModels = await remoteDataSource.fetchQuizzes();
    return quizModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> addQuiz(Quiz quiz) async {
    final model = QuizModel.fromEntity(quiz);
    await remoteDataSource.addQuiz(model);
  }

  @override
  Future<void> updateQuiz(Quiz quiz) async {
    final model = QuizModel.fromEntity(quiz);
    await remoteDataSource.updateQuiz(model);
  }

  @override
  Future<void> deleteQuiz(String id) async {
    await remoteDataSource.deleteQuiz(id);
  }
}
