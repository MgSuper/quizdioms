import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizdioms/presentation/user/data/repositories/user_phrase_repository_impl.dart';
import 'package:quizdioms/presentation/user/data/user_phrase_remote_data_source.dart';
import 'package:quizdioms/presentation/user/domain/repositories/user_phrase_repository.dart';
import 'package:quizdioms/presentation/user/domain/usecases/fetch_user_phrase_groups_usecase.dart';
import 'package:quizdioms/presentation/user/screens/phrases/controllers/user_phrase_group_list_controller.dart';
import 'package:quizdioms/presentation/user/screens/phrases/models/paginated_phrase_groups_state.dart';

final userPhraseRemoteDataSourceProvider = Provider((ref) {
  return UserPhraseRemoteDataSource(FirebaseFirestore.instance);
});

final userPhraseRepositoryProvider = Provider<UserPhraseRepository>((ref) {
  return UserPhraseRepositoryImpl(ref.read(userPhraseRemoteDataSourceProvider));
});

final fetchUserPhraseGroupsUseCaseProvider =
    Provider<FetchUserPhraseGroupsUseCase>((ref) {
  return FetchUserPhraseGroupsUseCase(ref.read(userPhraseRepositoryProvider));
});

final userPhraseGroupListControllerProvider =
    NotifierProvider<UserPhraseGroupListController, PaginatedPhraseGroupsState>(
  UserPhraseGroupListController.new,
);
