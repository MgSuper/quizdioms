import '../repositories/user_phrase_metadata_repository.dart';

class MarkPhraseGroupAsLearnedUseCase {
  final UserPhraseMetadataRepository repository;

  MarkPhraseGroupAsLearnedUseCase(this.repository);

  Future<void> call(String groupId) {
    return repository.markAsLearned(groupId);
  }
}

class FetchLearnedPhraseGroupIdsUseCase {
  final UserPhraseMetadataRepository repository;

  FetchLearnedPhraseGroupIdsUseCase(this.repository);

  Future<List<String>> call() {
    return repository.getLearnedPhraseGroupIds();
  }
}

class UnmarkPhraseGroupAsLearnedUseCase {
  final UserPhraseMetadataRepository repository;

  UnmarkPhraseGroupAsLearnedUseCase(this.repository);

  Future<void> call(String groupId) {
    return repository.unmarkAsLearned(groupId);
  }
}
