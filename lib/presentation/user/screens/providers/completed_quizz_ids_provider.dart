import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final completedQuizIdsProvider = FutureProvider<List<String>>((ref) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return [];

  final docSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

  final data = docSnapshot.data();
  final completedList = data?['completedQuizzes'] as List<dynamic>?;

  return completedList?.cast<String>() ?? [];
});
