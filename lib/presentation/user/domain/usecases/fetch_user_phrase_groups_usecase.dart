import 'package:quizdioms/presentation/admin/manage_phrases/data/models/phrase_group_model.dart';
import 'package:quizdioms/presentation/user/domain/repositories/user_phrase_repository.dart';

class FetchUserPhraseGroupsUseCase {
  final UserPhraseRepository repository;

  FetchUserPhraseGroupsUseCase(this.repository);

  Future<List<PhraseGroupModel>> call({
    required int offset,
    required int limit,
  }) {
    return repository.fetchPhraseGroups(offset: offset, limit: limit);
  }
}
