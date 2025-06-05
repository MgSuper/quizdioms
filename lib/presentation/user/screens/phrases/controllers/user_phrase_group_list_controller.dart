import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/user/domain/usecases/fetch_user_phrase_groups_usecase.dart';
import 'package:quizdioms/presentation/user/screens/phrases/models/paginated_phrase_groups_state.dart';
import 'package:quizdioms/presentation/user/screens/phrases/providers/user_phrase_group_providers.dart';

class UserPhraseGroupListController
    extends Notifier<PaginatedPhraseGroupsState> {
  late final FetchUserPhraseGroupsUseCase _fetchUseCase;
  final int _limit = 10;

  @override
  PaginatedPhraseGroupsState build() {
    _fetchUseCase = ref.read(fetchUserPhraseGroupsUseCaseProvider);

    // ✅ Fix: Initialize state before loading
    state = PaginatedPhraseGroupsState.initial();

    _loadPage(1);
    return state;
  }

  Future<void> _loadPage(int page) async {
    state = state.copyWith(isLoading: true);
    final offset = (page - 1) * _limit;
    final result = await _fetchUseCase(offset: offset, limit: _limit);

    state = state.copyWith(
      items: result,
      currentPage: page,
      totalPages: result.length < _limit ? page : page + 1,
      isLoading: false,
    );
  }

  void goToPage(int page) {
    _loadPage(page);
  }
}
