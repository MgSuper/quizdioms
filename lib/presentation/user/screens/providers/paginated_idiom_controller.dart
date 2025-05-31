import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/data/models/idioms.dart';

final paginatedIdiomProvider =
    StateNotifierProvider<PaginatedIdiomController, List<IdiomGroup>>(
        (ref) => PaginatedIdiomController());

class PaginatedIdiomController extends StateNotifier<List<IdiomGroup>> {
  PaginatedIdiomController() : super([]);

  final int _limit = 10;
  DocumentSnapshot? _lastDocument;
  bool isLoading = false;
  bool hasMore = true;

  Future<void> fetchNext() async {
    if (isLoading || !hasMore) return;
    isLoading = true;

    Query query = FirebaseFirestore.instance
        .collection('idioms')
        .orderBy('createdAt', descending: true)
        .limit(_limit);

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    final snapshot = await query.get();
    if (snapshot.docs.isNotEmpty) {
      _lastDocument = snapshot.docs.last;
    } else {
      hasMore = false;
    }

    final idiomGroups = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return idiomGroupFromFirestore(data, doc.id);
    }).toList();

    state = [...state, ...idiomGroups];
    isLoading = false;
  }

  void reset() {
    state = [];
    _lastDocument = null;
    hasMore = true;
  }
}
