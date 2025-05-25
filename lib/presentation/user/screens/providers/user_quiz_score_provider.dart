import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final userQuizScoreProvider = FutureProvider<Map<String, double>>((ref) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return {};

  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('quizResults')
      .get();

  return {
    for (var doc in snapshot.docs)
      doc.id: (doc['correctCount'] as int) / (doc['totalQuestions'] as int)
  };
});
