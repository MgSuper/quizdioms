import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_progress_provider.g.dart';

class UserProgress {
  final int idiomsLearned;
  final int phrasesLearned;
  final int quizzesCompleted;
  final double? avgScore; // Optional

  UserProgress({
    required this.idiomsLearned,
    required this.phrasesLearned,
    required this.quizzesCompleted,
    this.avgScore,
  });
}

@riverpod
Future<UserProgress> userProgress(Ref ref) async {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final uid = auth.currentUser?.uid;

  if (uid == null) throw Exception('User not logged in');

  // ✅ Count idioms from subcollection
  final idiomsSnapshot = await firestore
      .collection('users')
      .doc(uid)
      .collection('learned_idioms')
      .get();
  final idiomsLearned = idiomsSnapshot.size;

  // ✅ Count phrases from array field
  final phrasesDoc = await firestore
      .collection('users')
      .doc(uid)
      .collection('metadata')
      .doc('phrases')
      .get();

  final phrasesLearned =
      (phrasesDoc.data()?['learned_phrase_group_ids'] as List?)?.length ?? 0;

  final userDoc = await firestore.collection('users').doc(uid).get();
  final completedQuizIds =
      (userDoc.data()?['completedQuizzes'] as List?)?.cast<String>() ?? [];
  final quizzesCompleted = completedQuizIds.length;

  double totalScore = 0;
  if (completedQuizIds.isNotEmpty) {
    final resultsSnapshot = await firestore
        .collection('users')
        .doc(uid)
        .collection('quizResults')
        .get();

    for (final doc in resultsSnapshot.docs) {
      final score = (doc.data()['score'] as num?)?.toDouble() ?? 0;
      totalScore += score;
    }
  }

  final avgScore =
      quizzesCompleted > 0 ? (totalScore / quizzesCompleted) : null;

  return UserProgress(
    idiomsLearned: idiomsLearned,
    phrasesLearned: phrasesLearned,
    quizzesCompleted: quizzesCompleted,
    avgScore: avgScore,
  );
}
