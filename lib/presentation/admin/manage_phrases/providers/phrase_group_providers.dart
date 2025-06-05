import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizdioms/presentation/admin/manage_phrases/controllers/phrase_group_list_controller.dart';
import '../../../admin/manage_phrases/data/datasources/phrase_remote_data_source.dart';
import '../../../admin/manage_phrases/data/repositories/phrase_repository_impl.dart';
import '../../../admin/manage_phrases/domain/usecases/phrase_group_usecases.dart';
import '../../../admin/manage_phrases/data/models/phrase_group_model.dart';
import '../../../admin/manage_phrases/domain/repositories/phrase_repository.dart';

/// 🔗 Repository Provider
final phraseRepositoryProvider = Provider<PhraseRepository>((ref) {
  return PhraseRepositoryImpl(
      PhraseRemoteDataSource(FirebaseFirestore.instance));
});

/// 🧠 Use Case Providers
final fetchPhraseGroupsProvider = Provider<FetchPhraseGroups>((ref) {
  return FetchPhraseGroups(ref.watch(phraseRepositoryProvider));
});

final addPhraseGroupProvider =
    AutoDisposeNotifierProvider<AddPhraseGroup, void>(AddPhraseGroup.new);

final updatePhraseGroupProvider =
    AutoDisposeNotifierProvider<UpdatePhraseGroup, void>(UpdatePhraseGroup.new);

final deletePhraseGroupProvider =
    AutoDisposeNotifierProvider<DeletePhraseGroup, void>(DeletePhraseGroup.new);

/// 📦 Notifier Provider for UI List Management
final phraseGroupListControllerProvider =
    NotifierProvider<PhraseGroupListController, List<PhraseGroupModel>>(
  PhraseGroupListController.new,
);
