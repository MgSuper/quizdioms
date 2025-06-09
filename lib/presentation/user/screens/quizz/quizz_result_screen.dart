import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/entities/quiz.dart';
import 'package:quizdioms/presentation/user/screens/providers/completed_quizz_ids_provider.dart';
import 'package:quizdioms/presentation/user/screens/quizz/providers/user_quiz_score_provider.dart';
import 'package:quizdioms/presentation/user/widgets/user_app_bar.dart';

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
    final totalQuestions = quiz.questions.length;
    final score = ((correctAnswers / totalQuestions) * 100).round();

    final isWeb = MediaQuery.of(context).size.width >= 640;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const UserAppBar(title: 'Quiz Result'),
      body: Padding(
        padding: isWeb
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quiz Name:',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Color(0xFFD8E2E4)),
            ),
            const SizedBox(height: 4),
            Text(
              quiz.title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Color(0xFFD8E2E4), fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16),
            Text(
              'Score:',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Color(0xFFD8E2E4)),
            ),
            const SizedBox(height: 4),
            Text(
              '$score%',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Color(0xFFD8E2E4), fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12),
                backgroundColor: Color(0xFFD8E2E4),
                foregroundColor: Color(0xFF316E79),
              ),
              onPressed: () {
                ref.invalidate(userQuizScoreProvider); // 👈 Refresh score map
                ref.invalidate(
                    completedQuizIdsProvider); // 👈 Optional, if needed
                context.go('/user/quizzes', extra: quiz.id);
              },
              child: Text(
                'Back to Quizzes',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
