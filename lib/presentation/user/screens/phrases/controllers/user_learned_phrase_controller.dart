import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/user/domain/usecases/learned_phrase_group_usecases.dart';

import '../providers/user_phrase_metadata_providers.dart';

class UserLearnedPhraseController extends Notifier<List<String>> {
  late final FetchLearnedPhraseGroupIdsUseCase _fetchUseCase;
  late final MarkPhraseGroupAsLearnedUseCase _markUseCase;
  late final UnmarkPhraseGroupAsLearnedUseCase _unmarkUseCase;

  @override
  List<String> build() {
    _fetchUseCase = ref.read(fetchLearnedPhraseGroupIdsUseCaseProvider);
    _markUseCase = ref.read(markPhraseGroupAsLearnedUseCaseProvider);

    _loadLearnedGroups();
    return [];
  }

  Future<void> _loadLearnedGroups() async {
    final learnedIds = await _fetchUseCase();
    state = learnedIds;
  }

  Future<void> markAsLearned(String groupId) async {
    if (!state.contains(groupId)) {
      await _markUseCase(groupId);
      state = [...state, groupId];
    }
  }

  Future<void> unmarkAsLearned(String groupId) async {
    if (state.contains(groupId)) {
      await _unmarkUseCase(groupId);
      state = [...state]..remove(groupId);
    }
  }

  bool isLearned(String groupId) {
    return state.contains(groupId);
  }
}
