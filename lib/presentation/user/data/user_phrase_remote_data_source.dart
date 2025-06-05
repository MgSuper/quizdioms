import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizdioms/presentation/admin/manage_phrases/data/models/phrase_group_model.dart';

class UserPhraseRemoteDataSource {
  final FirebaseFirestore firestore;

  UserPhraseRemoteDataSource(this.firestore);

  CollectionReference get _phraseGroups => firestore.collection('phrases');

  Future<List<PhraseGroupModel>> fetchPhraseGroups({
    required int offset,
    required int limit,
  }) async {
    Query query = _phraseGroups.orderBy('created_at').limit(limit);

    // If offset > 0, paginate with startAfterDocument
    if (offset > 0) {
      final snapshot =
          await _phraseGroups.orderBy('created_at').limit(offset).get();

      final lastDoc = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;

      if (lastDoc != null) {
        query = query.startAfterDocument(lastDoc);
      }
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return PhraseGroupModel.fromJson(data);
    }).toList();
  }
}
