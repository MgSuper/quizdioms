import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/data/models/idioms.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/providers/idiom_usecase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'idiom_list_provider.g.dart';

@riverpod
Future<List<IdiomGroup>> idiomGroupList(Ref ref) async {
  final usecase = ref.watch(getAllIdiomGroupsUseCaseProvider);
  return usecase();
}
