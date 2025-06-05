import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/admin/manage_phrases/data/models/phrase_group_model.dart';
import 'package:quizdioms/presentation/admin/manage_phrases/domain/repositories/phrase_repository.dart';
import 'package:quizdioms/presentation/admin/manage_phrases/providers/phrase_group_providers.dart';

class FetchPhraseGroups {
  final PhraseRepository repository;

  FetchPhraseGroups(this.repository);

  Future<List<PhraseGroupModel>> call(
      {PhraseGroupModel? lastGroup, int limit = 10}) {
    return repository.fetchPhraseGroups(lastGroup: lastGroup, limit: limit);
  }
}

class AddPhraseGroup extends AutoDisposeNotifier<void> {
  late final PhraseRepository repository;

  @override
  void build() {
    repository = ref.read(phraseRepositoryProvider);
  }

  Future<void> add(PhraseGroupModel group) async {
    await repository.addPhraseGroup(group);
  }
}

// ✅ Update Phrase Group — Notifier version
class UpdatePhraseGroup extends AutoDisposeNotifier<void> {
  late final PhraseRepository repository;

  @override
  void build() {
    repository = ref.read(phraseRepositoryProvider);
  }

  Future<void> update(PhraseGroupModel group) async {
    await repository.updatePhraseGroup(group);
  }
}

class DeletePhraseGroup extends AutoDisposeNotifier<void> {
  late final PhraseRepository repository;

  @override
  void build() {
    repository = ref.read(phraseRepositoryProvider);
  }

  Future<void> delete(String id) async {
    await repository.deletePhraseGroup(id);
  }
}
