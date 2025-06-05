import 'package:quizdioms/presentation/admin/manage_phrases/data/models/phrase_group_model.dart';

abstract class UserPhraseRepository {
  Future<List<PhraseGroupModel>> fetchPhraseGroups({
    required int offset,
    required int limit,
  });
}
