import 'package:quizdioms/presentation/admin/manage_phrases/data/models/phrase_group_model.dart';

abstract class PhraseRepository {
  Future<List<PhraseGroupModel>> fetchPhraseGroups(
      {PhraseGroupModel? lastGroup, int limit});
  Future<void> addPhraseGroup(PhraseGroupModel group);
  Future<void> updatePhraseGroup(PhraseGroupModel group);
  Future<void> deletePhraseGroup(String id);
}
