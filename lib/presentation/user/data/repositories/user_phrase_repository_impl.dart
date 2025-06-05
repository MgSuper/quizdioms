import 'package:quizdioms/presentation/admin/manage_phrases/data/models/phrase_group_model.dart';
import 'package:quizdioms/presentation/user/data/user_phrase_remote_data_source.dart';
import 'package:quizdioms/presentation/user/domain/repositories/user_phrase_repository.dart';

class UserPhraseRepositoryImpl implements UserPhraseRepository {
  final UserPhraseRemoteDataSource remoteDataSource;

  UserPhraseRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<PhraseGroupModel>> fetchPhraseGroups({
    required int offset,
    required int limit,
  }) {
    return remoteDataSource.fetchPhraseGroups(offset: offset, limit: limit);
  }
}
