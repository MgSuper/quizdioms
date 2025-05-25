import 'package:quizdioms/presentation/admin/manage_quizzes/data/models/idioms.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/repositories/idiom_repository.dart';

class AddIdiomGroupUseCase {
  final IdiomRepository repository;

  AddIdiomGroupUseCase(this.repository);

  Future<void> call(IdiomGroup group) {
    return repository.addIdiomGroup(group);
  }
}
