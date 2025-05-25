import 'package:quizdioms/presentation/admin/manage_quizzes/data/models/idioms.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/providers/idiom_usecase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/usecases/add_idiom_group_usecase.dart';

part 'idiom_controller.g.dart';

@riverpod
class IdiomController extends _$IdiomController {
  late final AddIdiomGroupUseCase _useCase;

  @override
  AsyncValue<void> build() {
    _useCase = ref.watch(addIdiomGroupUseCaseProvider);
    return const AsyncData(null);
  }

  Future<void> submit({
    required List<Idiom> idioms,
    required String groupName,
  }) async {
    if (idioms.length != 3) {
      state = AsyncError('Exactly 3 idioms required', StackTrace.current);
      return;
    }

    state = const AsyncLoading();

    final group = IdiomGroup(
      id: const Uuid().v4(),
      groupName: groupName,
      idioms: idioms,
      createdAt: DateTime.now(), // won't be used if Firestore sets it
    );

    try {
      await _useCase(group);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void reset() {
    state = const AsyncData(null);
  }
}
