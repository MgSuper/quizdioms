import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/entities/quiz.dart';

final paginatedQuizProvider =
    StateNotifierProvider.autoDispose<PaginatedQuizController, List<Quiz>>(
  (ref) => PaginatedQuizController(),
);

class PaginatedQuizController extends StateNotifier<List<Quiz>> {
  PaginatedQuizController() : super([]) {
    _fetchInitial();
  }

  static const int _limit = 10;
  DocumentSnapshot? _lastDoc;
  bool _hasMore = true;
  bool _isLoading = false;

  final _firestore = FirebaseFirestore.instance;

  bool get hasMore => _hasMore;
  bool get isLoading => _isLoading;

  Future<void> _fetchInitial() async {
    _hasMore = true;
    _isLoading = false;
    _lastDoc = null;
    state = [];

    final snapshot = await _firestore
        .collection('quizzes')
        .orderBy('createdAt')
        .limit(_limit)
        .get();

    final docs = snapshot.docs;

    if (docs.isNotEmpty) {
      _lastDoc = docs.last;

      final newQuizzes = docs
          .map((doc) => Quiz.fromJson({...doc.data(), 'id': doc.id}))
          .toList();

      // If less than limit, no more to fetch
      _hasMore = newQuizzes.length == _limit;
      state = newQuizzes;
    } else {
      _hasMore = false;
      state = [];
    }
  }

  Future<void> fetchNext() async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;

    final query = _firestore
        .collection('quizzes')
        .orderBy('createdAt')
        .startAfterDocument(_lastDoc!)
        .limit(_limit);

    final snapshot = await query.get();

    final docs = snapshot.docs;

    if (docs.isEmpty) {
      _hasMore = false;
    } else {
      _lastDoc = docs.last;

      final newQuizzes =
          docs.map((e) => Quiz.fromJson({...e.data(), 'id': e.id})).toList();

      // ✅ Check if we're already seeing the last doc from Firestore
      if (docs.length < _limit) {
        _hasMore = false;
      }

      state = [...state, ...newQuizzes];
    }

    _isLoading = false;
  }
}
