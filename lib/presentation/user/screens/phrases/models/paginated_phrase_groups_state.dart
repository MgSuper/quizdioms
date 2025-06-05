import 'package:quizdioms/presentation/admin/manage_phrases/data/models/phrase_group_model.dart';

class PaginatedPhraseGroupsState {
  final List<PhraseGroupModel> items;
  final int currentPage;
  final int totalPages;
  final bool isLoading;

  PaginatedPhraseGroupsState({
    required this.items,
    required this.currentPage,
    required this.totalPages,
    required this.isLoading,
  });

  factory PaginatedPhraseGroupsState.initial() => PaginatedPhraseGroupsState(
        items: [],
        currentPage: 1,
        totalPages: 1,
        isLoading: false,
      );

  PaginatedPhraseGroupsState copyWith({
    List<PhraseGroupModel>? items,
    int? currentPage,
    int? totalPages,
    bool? isLoading,
  }) {
    return PaginatedPhraseGroupsState(
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
