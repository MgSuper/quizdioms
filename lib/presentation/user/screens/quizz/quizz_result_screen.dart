// import 'package:flutter/material.dart';
// import 'package:quizdioms/presentation/admin/manage_quizzes/domain/entities/quiz.dart';

// class QuizResultScreen extends StatelessWidget {
//   final Quiz quiz;
//   final int correctAnswers;

//   const QuizResultScreen({
//     super.key,
//     required this.quiz,
//     required this.correctAnswers,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final totalQuestions = quiz.questions.length;
//     final scorePercentage = (correctAnswers / totalQuestions) * 100;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quiz Result'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text(
//               'You answered $correctAnswers out of $totalQuestions questions correctly!',
//               style: TextStyle(fontSize: 20),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Your Score: ${scorePercentage.toStringAsFixed(2)}%',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate back to the quiz list or home screen
//                 Navigator.popUntil(
//                     context, ModalRoute.withName('/user/quizzes'));
//               },
//               child: Text('Back to Quizzes'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// lib/presentation/user/screens/quizz/quiz_result_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/entities/quiz.dart';
import 'package:quizdioms/presentation/user/screens/providers/completed_quizz_ids_provider.dart';
import 'package:quizdioms/presentation/user/screens/providers/user_quiz_score_provider.dart';

class QuizResultScreen extends ConsumerWidget {
  final Quiz quiz;
  final int correctAnswers;

  const QuizResultScreen({
    super.key,
    required this.quiz,
    required this.correctAnswers,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('quiz ${quiz.questions.length}');
    print('correctAnswers $correctAnswers');
    final totalQuestions = quiz.questions.length;
    final score = ((correctAnswers / totalQuestions) * 100).round();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Quiz Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quiz Name:',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Color(0xFFD8E2E4)),
            ),
            Text(
              quiz.title,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Color(0xFFD8E2E4)),
            ),
            const SizedBox(height: 16),
            Text(
              'Score:',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Color(0xFFD8E2E4)),
            ),
            Text(
              '$score%',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Color(0xFFD8E2E4)),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Color(0xFFD8E2E4),
                foregroundColor: Color(0xFF316E79),
              ),
              onPressed: () {
                ref.invalidate(userQuizScoreProvider); // 👈 Refresh score map
                ref.invalidate(
                    completedQuizIdsProvider); // 👈 Optional, if needed
                context.go('/user/quizzes');
              },
              child: const Text('Back to Quizzes'),
            ),
          ],
        ),
      ),
    );
  }
}
