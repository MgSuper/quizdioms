import 'package:quizdioms/presentation/user/data/learned_idiom_remote_data_source.dart';
import 'package:quizdioms/presentation/user/domain/repositories/learned_idiom_repository.dart';

class LearnedIdiomRepositoryImpl implements LearnedIdiomRepository {
  final LearnedIdiomRemoteDataSource remote;

  LearnedIdiomRepositoryImpl(this.remote);

  @override
  Future<void> markAsLearned(String groupId) => remote.markAsLearned(groupId);

  @override
  Future<bool> isLearned(String groupId) => remote.isLearned(groupId);
}
