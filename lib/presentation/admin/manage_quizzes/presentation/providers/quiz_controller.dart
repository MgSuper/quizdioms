import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/entities/quiz.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/providers/quiz_usecase_providers.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/usecases/add_quiz.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/usecases/delete_quiz.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/usecases/get_all_quizzes.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/usecases/update_quiz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'quiz_controller.g.dart';

@riverpod
class QuizController extends _$QuizController {
  @override
  Future<List<Quiz>> build() async {
    final getAllQuizzes = ref.read(getAllQuizzesProvider);
    return await getAllQuizzes();
  }

  Future<void> addQuiz(Quiz quiz) async {
    final addQuiz = ref.read(addQuizProvider);
    final getAllQuizzes = ref.read(getAllQuizzesProvider);
    await addQuiz(quiz);
    state = AsyncData(await getAllQuizzes());
  }

  Future<void> updateQuiz(Quiz quiz) async {
    final updateQuiz = ref.read(updateQuizProvider);
    final getAllQuizzes = ref.read(getAllQuizzesProvider);
    await updateQuiz(quiz);
    state = AsyncData(await getAllQuizzes());
  }

  Future<void> deleteQuiz(String id) async {
    final deleteQuiz = ref.read(deleteQuizProvider);
    final getAllQuizzes = ref.read(getAllQuizzesProvider);
    await deleteQuiz(id);
    state = AsyncData(await getAllQuizzes());
  }
}
