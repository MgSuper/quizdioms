import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserPhraseMetadataRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  UserPhraseMetadataRemoteDataSource(this.firestore, this.auth);

  DocumentReference<Map<String, dynamic>> get _docRef {
    final uid = auth.currentUser!.uid;
    return firestore
        .collection('users')
        .doc(uid)
        .collection('metadata')
        .doc('phrases');
  }

  Future<List<String>> getLearnedPhraseGroupIds() async {
    final doc = await _docRef.get();
    if (!doc.exists) return [];
    final data = doc.data();
    return (data?['learned_phrase_group_ids'] as List?)?.cast<String>() ?? [];
  }

  Future<void> markAsLearned(String groupId) async {
    await _docRef.set({
      'learned_phrase_group_ids': FieldValue.arrayUnion([groupId])
    }, SetOptions(merge: true));
  }

  Future<void> unmarkAsLearned(String groupId) async {
    await _docRef.set({
      'learned_phrase_group_ids': FieldValue.arrayRemove([groupId])
    }, SetOptions(merge: true));
  }
}
