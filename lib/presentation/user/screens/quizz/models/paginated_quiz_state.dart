import 'package:quizdioms/presentation/admin/manage_quizzes/domain/entities/quiz.dart';

class PaginatedQuizState {
  final List<Quiz> items;
  final int currentPage;
  final int totalPages;
  final bool isLoading;

  PaginatedQuizState({
    required this.items,
    required this.currentPage,
    required this.totalPages,
    required this.isLoading,
  });

  factory PaginatedQuizState.initial() => PaginatedQuizState(
        items: [],
        currentPage: 1,
        totalPages: 1,
        isLoading: false,
      );

  PaginatedQuizState copyWith({
    List<Quiz>? items,
    int? currentPage,
    int? totalPages,
    bool? isLoading,
  }) {
    return PaginatedQuizState(
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
