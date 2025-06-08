import 'package:quizdioms/presentation/user/screens/profile/models/user_progress_model.dart';

abstract class UserProgressRepository {
  Future<UserProgress> fetchProgress();
}
