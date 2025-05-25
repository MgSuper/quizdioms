// lib/features/admin/manage_quizzes/domain/providers/quiz_usecase_providers.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/data/datasources/quiz_remote_data_source.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/data/repositories/quiz_repository_impl.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/usecases/get_all_quizzes.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/usecases/add_quiz.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/usecases/update_quiz.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/usecases/delete_quiz.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/repositories/quiz_repository.dart';

// Assuming you have a provider for your repository
final quizRepositoryProvider = Provider<QuizRepository>((ref) {
  final firestore = FirebaseFirestore.instance;
  final remoteDataSource = QuizRemoteDataSource(firestore);
  return QuizRepositoryImpl(remoteDataSource);
});

final getAllQuizzesProvider = Provider<GetAllQuizzes>((ref) {
  final repository = ref.read(quizRepositoryProvider);
  return GetAllQuizzes(repository);
});

final addQuizProvider = Provider<AddQuiz>((ref) {
  final repository = ref.read(quizRepositoryProvider);
  return AddQuiz(repository);
});

final updateQuizProvider = Provider<UpdateQuiz>((ref) {
  final repository = ref.read(quizRepositoryProvider);
  return UpdateQuiz(repository);
});

final deleteQuizProvider = Provider<DeleteQuiz>((ref) {
  final repository = ref.read(quizRepositoryProvider);
  return DeleteQuiz(repository);
});
