import 'package:quizdioms/presentation/admin/manage_quizzes/data/models/idioms.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/repositories/idiom_repository.dart';

class GetAllIdiomGroupsUseCase {
  final IdiomRepository repository;

  GetAllIdiomGroupsUseCase(this.repository);

  Future<List<IdiomGroup>> call() {
    return repository.getIdiomGroups();
  }
}
