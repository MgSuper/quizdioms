import 'package:quizdioms/presentation/admin/manage_quizzes/data/models/idioms.dart';

class PaginatedIdiomState {
  final List<IdiomGroup> items;
  final int currentPage;
  final int totalPages;
  final bool isLoading;

  PaginatedIdiomState({
    required this.items,
    required this.currentPage,
    required this.totalPages,
    required this.isLoading,
  });

  factory PaginatedIdiomState.initial() => PaginatedIdiomState(
        items: [],
        currentPage: 1,
        totalPages: 1,
        isLoading: false,
      );

  PaginatedIdiomState copyWith({
    List<IdiomGroup>? items,
    int? currentPage,
    int? totalPages,
    bool? isLoading,
  }) {
    return PaginatedIdiomState(
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
