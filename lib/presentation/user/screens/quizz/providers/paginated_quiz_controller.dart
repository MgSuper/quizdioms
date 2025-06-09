import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/entities/quiz.dart';
import 'package:quizdioms/presentation/user/screens/quizz/models/paginated_quiz_state.dart';

class PaginatedQuizController extends Notifier<PaginatedQuizState> {
  final int _limit = 5;
  late final FirebaseFirestore _firestore;

  /// To keep track of page start docs
  final List<DocumentSnapshot> _pageStartDocs = [];

  @override
  PaginatedQuizState build() {
    _firestore = FirebaseFirestore.instance;
    Future.microtask(() => _loadPage(1));
    return PaginatedQuizState.initial();
  }

  Future<void> _loadPage(int page) async {
    state = state.copyWith(isLoading: true);

    Query query = _firestore.collection('quizzes').orderBy('createdAt');

    if (page > 1 && _pageStartDocs.length >= page - 1) {
      query = query.startAfterDocument(_pageStartDocs[page - 2]);
    }

    final snapshot = await query.limit(_limit).get();

    if (snapshot.docs.isNotEmpty) {
      if (_pageStartDocs.length < page) {
        _pageStartDocs.add(snapshot.docs.last);
      }
    }

    final totalSnapshot = await _firestore.collection('quizzes').count().get();
    final total = totalSnapshot.count;
    final totalPages = (total! / _limit).ceil();

    final items = snapshot.docs
        .map((doc) => Quiz.fromJson(
            {...doc.data() as Map<String, dynamic>, 'id': doc.id}))
        .toList();

    state = state.copyWith(
      items: items,
      currentPage: page,
      totalPages: totalPages,
      isLoading: false,
    );
  }

  List<String> unlockedQuizIds(Map<String, double> scoreMap) {
    final allUnlockedIds = scoreMap.entries
        .where((e) => e.value >= 0.8)
        .map((e) => e.key)
        .toList();
    return allUnlockedIds;
  }

  void goToPage(int page) {
    _loadPage(page);
  }
}
