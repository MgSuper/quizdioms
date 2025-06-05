abstract class UserPhraseMetadataRepository {
  Future<List<String>> getLearnedPhraseGroupIds();
  Future<void> markAsLearned(String groupId);
  Future<void> unmarkAsLearned(String groupId);
}
