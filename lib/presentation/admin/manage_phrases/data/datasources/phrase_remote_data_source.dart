import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizdioms/presentation/admin/manage_phrases/data/models/phrase_group_model.dart';

class PhraseRemoteDataSource {
  final FirebaseFirestore firestore;

  PhraseRemoteDataSource(this.firestore);

  CollectionReference get _phraseGroups => firestore.collection('phrases');

  Future<List<PhraseGroupModel>> fetchPhraseGroups({
    PhraseGroupModel? lastGroup,
    int limit = 10,
  }) async {
    Query query =
        _phraseGroups.orderBy('created_at', descending: false).limit(limit);

    if (lastGroup?.id != null) {
      final lastSnapshot = await _phraseGroups.doc(lastGroup!.id!).get();
      query = query.startAfterDocument(lastSnapshot);
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return PhraseGroupModel.fromJson(data);
    }).toList();
  }

  Future<void> addPhraseGroup(PhraseGroupModel group) {
    return _phraseGroups.add({
      'group_name': group.groupName,
      'created_at': group.createdAt,
      'phrases': group.phrases.map((p) => p.toJson()).toList(),
    });
  }

  Future<void> updatePhraseGroup(PhraseGroupModel group) {
    return _phraseGroups.doc(group.id).set({
      'group_name': group.groupName,
      'created_at': group.createdAt,
      'phrases': group.phrases.map((p) => p.toJson()).toList(),
    });
  }

  Future<void> deletePhraseGroup(String id) {
    return _phraseGroups.doc(id).delete();
  }
}
