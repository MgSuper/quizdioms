import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/admin/manage_phrases/data/models/phrase_group_model.dart';
import 'package:quizdioms/presentation/admin/manage_phrases/domain/usecases/phrase_group_usecases.dart';
import 'package:quizdioms/presentation/admin/manage_phrases/providers/phrase_group_providers.dart';

class PhraseGroupListController extends Notifier<List<PhraseGroupModel>> {
  late final FetchPhraseGroups _fetchPhraseGroups;
  PhraseGroupModel? _lastFetched;
  bool _hasMore = true;

  @override
  List<PhraseGroupModel> build() {
    _fetchPhraseGroups = ref.read(fetchPhraseGroupsProvider);
    return [];
  }

  bool get hasMore => _hasMore;

  Future<void> fetchNext({int limit = 10}) async {
    if (!_hasMore) return;
    final groups =
        await _fetchPhraseGroups(lastGroup: _lastFetched, limit: limit);
    if (groups.isEmpty) {
      _hasMore = false;
    } else {
      _lastFetched = groups.last;
      state = [...state, ...groups];
    }
  }

  void reset() {
    state = [];
    _lastFetched = null;
    _hasMore = true;
  }
}
