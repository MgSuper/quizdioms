import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LearnedIdiomRemoteDataSource {
  Future<void> markAsLearned(String groupId);
  Future<bool> isLearned(String groupId);
}

class LearnedIdiomRemoteDataSourceImpl implements LearnedIdiomRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  LearnedIdiomRemoteDataSourceImpl({
    required this.firestore,
    required this.auth,
  });

  @override
  Future<void> markAsLearned(String groupId) async {
    final uid = auth.currentUser?.uid;
    if (uid == null) throw Exception('User not logged in');

    await firestore
        .collection('users')
        .doc(uid)
        .collection('learned_idioms')
        .doc(groupId)
        .set({
      'groupId': groupId,
      'markedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<bool> isLearned(String groupId) async {
    final uid = auth.currentUser?.uid;
    if (uid == null) throw Exception('User not logged in');

    final doc = await firestore
        .collection('users')
        .doc(uid)
        .collection('learned_idioms')
        .doc(groupId)
        .get();

    return doc.exists;
  }
}
