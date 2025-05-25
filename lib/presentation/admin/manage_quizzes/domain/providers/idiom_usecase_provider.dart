import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/data/datasources/idiom_remote_data_source.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/data/repositories/idiom_repository_impl.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/repositories/idiom_repository.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/usecases/add_idiom_group_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/usecases/get_all_idiom_groups_usecase.dart';

/// Remote data source provider
final idiomRemoteDataSourceProvider = Provider<IdiomRemoteDataSource>((ref) {
  return IdiomRemoteDataSourceImpl(FirebaseFirestore.instance);
});

/// Repository provider
final idiomRepositoryProvider = Provider<IdiomRepository>((ref) {
  final remoteDataSource = ref.watch(idiomRemoteDataSourceProvider);
  return IdiomRepositoryImpl(remoteDataSource: remoteDataSource);
});

/// AddIdiomGroupUseCase provider
final addIdiomGroupUseCaseProvider = Provider<AddIdiomGroupUseCase>((ref) {
  final repository = ref.watch(idiomRepositoryProvider);
  return AddIdiomGroupUseCase(repository);
});

final getAllIdiomGroupsUseCaseProvider =
    Provider<GetAllIdiomGroupsUseCase>((ref) {
  final repo = ref.watch(idiomRepositoryProvider);
  return GetAllIdiomGroupsUseCase(repo);
});
