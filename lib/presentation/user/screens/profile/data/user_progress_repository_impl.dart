import 'package:quizdioms/presentation/user/screens/profile/data/user_progress_remote_data_source.dart';
import 'package:quizdioms/presentation/user/screens/profile/data/user_progress_repository.dart';
import 'package:quizdioms/presentation/user/screens/profile/models/user_progress_model.dart';

class UserProgressRepositoryImpl implements UserProgressRepository {
  final UserProgressRemoteDataSource dataSource;

  UserProgressRepositoryImpl(this.dataSource);

  @override
  Future<UserProgress> fetchProgress() => dataSource.fetchProgress();
}
