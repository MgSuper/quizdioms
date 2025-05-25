import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/data/models/quiz_model.dart';

class QuizRemoteDataSource {
  final FirebaseFirestore firestore;

  QuizRemoteDataSource(this.firestore);

  CollectionReference get _quizCollection => firestore.collection('quizzes');

  Future<List<QuizModel>> fetchQuizzes() async {
    final snapshot = await firestore.collection('quizzes').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return QuizModel.fromJson({...data, 'id': doc.id});
    }).toList();
  }

  Future<void> addQuiz(QuizModel quiz) async {
    final data = {
      'title': quiz.title,
      'questions': quiz.questions.map((q) => q.toJson()).toList(),
    };

    await firestore.collection('quizzes').add(data);
  }

  Future<void> updateQuiz(QuizModel quiz) async {
    final data = {
      'title': quiz.title,
      'questions': quiz.questions.map((q) => q.toJson()).toList(),
    };
    await _quizCollection.doc(quiz.id).update(data);
  }

  Future<void> deleteQuiz(String id) async {
    await _quizCollection.doc(id).delete();
  }
}
