import 'package:quizdioms/presentation/user/data/user_phrase_metadata_remote_data_source.dart';

import '../../domain/repositories/user_phrase_metadata_repository.dart';

class UserPhraseMetadataRepositoryImpl implements UserPhraseMetadataRepository {
  final UserPhraseMetadataRemoteDataSource remote;

  UserPhraseMetadataRepositoryImpl(this.remote);

  @override
  Future<List<String>> getLearnedPhraseGroupIds() {
    return remote.getLearnedPhraseGroupIds();
  }

  @override
  Future<void> markAsLearned(String groupId) {
    return remote.markAsLearned(groupId);
  }

  @override
  Future<void> unmarkAsLearned(String groupId) {
    return remote.unmarkAsLearned(groupId);
  }
}
