import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/entities/quiz.dart';
import 'package:quizdioms/presentation/user/screens/quizz/models/paginated_quiz_state.dart';
import 'paginated_quiz_controller.dart';

final paginatedQuizControllerProvider =
    NotifierProvider<PaginatedQuizController, PaginatedQuizState>(
        PaginatedQuizController.new);

final paginatedQuizItemsProvider = Provider<List<Quiz>>(
  (ref) => ref.watch(paginatedQuizControllerProvider).items,
);
