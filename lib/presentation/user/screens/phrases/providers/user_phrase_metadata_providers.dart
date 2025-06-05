import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizdioms/presentation/user/data/repositories/user_phrase_metadata_repository_impl.dart';
import 'package:quizdioms/presentation/user/data/user_phrase_metadata_remote_data_source.dart';
import 'package:quizdioms/presentation/user/domain/repositories/user_phrase_metadata_repository.dart';
import 'package:quizdioms/presentation/user/domain/usecases/learned_phrase_group_usecases.dart';
import '../controllers/user_learned_phrase_controller.dart';

/// 🔌 Remote Data Source
final userPhraseMetadataRemoteDataSourceProvider =
    Provider<UserPhraseMetadataRemoteDataSource>((ref) {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  return UserPhraseMetadataRemoteDataSource(firestore, auth);
});

/// 💾 Repository
final userPhraseMetadataRepositoryProvider =
    Provider<UserPhraseMetadataRepository>((ref) {
  final remoteDataSource =
      ref.watch(userPhraseMetadataRemoteDataSourceProvider);
  return UserPhraseMetadataRepositoryImpl(remoteDataSource);
});

/// 📡 Use Cases
final fetchLearnedPhraseGroupIdsUseCaseProvider =
    Provider<FetchLearnedPhraseGroupIdsUseCase>((ref) {
  return FetchLearnedPhraseGroupIdsUseCase(
    ref.watch(userPhraseMetadataRepositoryProvider),
  );
});

final markPhraseGroupAsLearnedUseCaseProvider =
    Provider<MarkPhraseGroupAsLearnedUseCase>((ref) {
  return MarkPhraseGroupAsLearnedUseCase(
    ref.watch(userPhraseMetadataRepositoryProvider),
  );
});

final unmarkPhraseGroupAsLearnedUseCaseProvider =
    Provider<UnmarkPhraseGroupAsLearnedUseCase>((ref) {
  return UnmarkPhraseGroupAsLearnedUseCase(
      ref.read(userPhraseMetadataRepositoryProvider));
});

/// 📦 Controller
final userLearnedPhraseControllerProvider =
    NotifierProvider<UserLearnedPhraseController, List<String>>(
  UserLearnedPhraseController.new,
);
