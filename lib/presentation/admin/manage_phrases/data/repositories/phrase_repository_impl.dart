import 'package:quizdioms/presentation/admin/manage_phrases/data/datasources/phrase_remote_data_source.dart';
import 'package:quizdioms/presentation/admin/manage_phrases/data/models/phrase_group_model.dart';
import 'package:quizdioms/presentation/admin/manage_phrases/domain/repositories/phrase_repository.dart';

class PhraseRepositoryImpl implements PhraseRepository {
  final PhraseRemoteDataSource remote;

  PhraseRepositoryImpl(this.remote);

  @override
  Future<List<PhraseGroupModel>> fetchPhraseGroups({
    PhraseGroupModel? lastGroup,
    int limit = 10,
  }) {
    return remote.fetchPhraseGroups(lastGroup: lastGroup, limit: limit);
  }

  @override
  Future<void> addPhraseGroup(PhraseGroupModel group) {
    return remote.addPhraseGroup(group);
  }

  @override
  Future<void> updatePhraseGroup(PhraseGroupModel group) {
    return remote.updatePhraseGroup(group);
  }

  @override
  Future<void> deletePhraseGroup(String id) {
    return remote.deletePhraseGroup(id);
  }
}
