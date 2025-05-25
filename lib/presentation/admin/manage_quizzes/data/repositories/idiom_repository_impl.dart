import 'package:quizdioms/presentation/admin/manage_quizzes/data/datasources/idiom_remote_data_source.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/data/models/idioms.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/repositories/idiom_repository.dart';

class IdiomRepositoryImpl implements IdiomRepository {
  final IdiomRemoteDataSource remoteDataSource;

  IdiomRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> addIdiomGroup(IdiomGroup group) {
    return remoteDataSource.addIdiomGroup(group);
  }

  @override
  Future<List<IdiomGroup>> getIdiomGroups() {
    return remoteDataSource.getIdiomGroups();
  }
}
