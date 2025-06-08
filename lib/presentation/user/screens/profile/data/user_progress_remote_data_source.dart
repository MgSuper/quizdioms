import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizdioms/presentation/user/screens/profile/models/user_progress_model.dart';

class UserProgressRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  UserProgressRemoteDataSource(this.firestore, this.auth);

  Future<UserProgress> fetchProgress() async {
    final uid = auth.currentUser!.uid;
    final doc = await firestore
        .collection('users')
        .doc(uid)
        .collection('metadata')
        .doc('progress')
        .get();

    if (!doc.exists) {
      return UserProgress(
          idiomsLearned: 0,
          phrasesLearned: 0,
          quizzesCompleted: 0,
          averageScore: 0);
    }

    return UserProgress.fromMap(doc.data()!);
  }
}
