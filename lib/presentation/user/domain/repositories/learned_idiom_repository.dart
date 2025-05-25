abstract class LearnedIdiomRepository {
  Future<void> markAsLearned(String groupId);
  Future<bool> isLearned(String groupId);
}
