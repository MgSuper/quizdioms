import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/data/models/idioms.dart';
import 'package:quizdioms/presentation/user/screens/idioms/models/paginated_idiom_state.dart';

class PaginatedIdiomController extends Notifier<PaginatedIdiomState> {
  final int _limit = 10;
  late final FirebaseFirestore _firestore;

  final List<DocumentSnapshot> _pageStartDocs = [];

  @override
  PaginatedIdiomState build() {
    _firestore = FirebaseFirestore.instance;
    Future.microtask(() => _loadPage(1));
    return PaginatedIdiomState.initial();
  }

  Future<void> _loadPage(int page) async {
    state = state.copyWith(isLoading: true);

    Query query =
        _firestore.collection('idioms').orderBy('createdAt', descending: true);

    if (page > 1 && _pageStartDocs.length >= page - 1) {
      query = query.startAfterDocument(_pageStartDocs[page - 2]);
    }

    final snapshot = await query.limit(_limit).get();

    if (snapshot.docs.isNotEmpty) {
      if (_pageStartDocs.length < page) {
        _pageStartDocs.add(snapshot.docs.last);
      }
    }

    final totalSnapshot = await _firestore.collection('idioms').count().get();
    final total = totalSnapshot.count;
    final totalPages = (total! / _limit).ceil();

    final idiomGroups = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return idiomGroupFromFirestore(data, doc.id);
    }).toList();

    state = state.copyWith(
      items: idiomGroups,
      currentPage: page,
      totalPages: totalPages,
      isLoading: false,
    );
  }

  void goToPage(int page) {
    _loadPage(page);
  }
}
