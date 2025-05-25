import 'package:quizdioms/presentation/admin/manage_quizzes/data/models/idioms.dart';

abstract class IdiomRepository {
  Future<void> addIdiomGroup(IdiomGroup group);
  Future<List<IdiomGroup>> getIdiomGroups();
}
