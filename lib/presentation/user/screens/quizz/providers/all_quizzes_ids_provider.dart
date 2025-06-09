import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allQuizIdsProvider = FutureProvider<List<String>>((ref) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('quizzes')
      .orderBy('createdAt')
      .get();

  return snapshot.docs.map((doc) => doc.id).toList();
});
