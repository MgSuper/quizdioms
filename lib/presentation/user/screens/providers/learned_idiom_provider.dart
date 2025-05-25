import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/user/data/learned_idiom_remote_data_source.dart';
import 'package:quizdioms/presentation/user/data/repositories/learned_idiom_repository_impl.dart';
import 'package:quizdioms/presentation/user/domain/repositories/learned_idiom_repository.dart';

final learnedIdiomRepoProvider = Provider<LearnedIdiomRepository>((ref) {
  return LearnedIdiomRepositoryImpl(
    LearnedIdiomRemoteDataSourceImpl(
      firestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance,
    ),
  );
});

final isGroupLearnedProvider =
    FutureProvider.family<bool, String>((ref, groupId) async {
  final repo = ref.watch(learnedIdiomRepoProvider);
  return repo.isLearned(groupId);
});
