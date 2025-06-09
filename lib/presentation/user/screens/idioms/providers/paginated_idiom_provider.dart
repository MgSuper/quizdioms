import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/data/models/idioms.dart';
import 'package:quizdioms/presentation/user/screens/idioms/models/paginated_idiom_state.dart';
import 'package:quizdioms/presentation/user/screens/idioms/providers/paginated_idiom_controller.dart';

final paginatedIdiomControllerProvider =
    NotifierProvider<PaginatedIdiomController, PaginatedIdiomState>(
  PaginatedIdiomController.new,
);

final paginatedIdiomItemsProvider = Provider<List<IdiomGroup>>(
  (ref) => ref.watch(paginatedIdiomControllerProvider).items,
);
