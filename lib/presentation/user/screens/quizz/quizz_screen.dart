import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/presentation/providers/quiz_controller.dart';
import 'package:quizdioms/presentation/user/navigation/responsive_wrapper.dart';
import 'package:quizdioms/presentation/user/screens/providers/user_quiz_score_provider.dart';
import 'package:quizdioms/presentation/user/widgets/quiz_card_skeleton.dart';
import 'package:quizdioms/presentation/user/widgets/user_app_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class QuizzScreen extends ConsumerWidget {
  const QuizzScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizzesAsync = ref.watch(quizControllerProvider);
    final quizScoresAsync = ref.watch(userQuizScoreProvider);

    return Scaffold(
      appBar: const UserAppBar(title: 'Quizzes'),
      backgroundColor: Colors.transparent,
      body: ResponsiveWrapper(
        child: quizzesAsync.when(
          data: (quizzes) {
            return quizScoresAsync.when(
              data: (scoreMap) {
                return AnimationLimiter(
                  child: ListView.builder(
                    padding:
                        kIsWeb ? EdgeInsets.zero : const EdgeInsets.all(16),
                    itemCount: quizzes.length,
                    itemBuilder: (context, index) {
                      final quiz = quizzes[index];
                      final percent = scoreMap[quiz.id] ?? 0.0;
                      final isCompleted = scoreMap.containsKey(quiz.id);

                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Card(
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () {
                                  context.push('/user/quiz/attempt',
                                      extra: quiz);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  child: Row(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CircularPercentIndicator(
                                        radius: 30.0,
                                        lineWidth: 6.0,
                                        animation: true,
                                        percent: percent,
                                        center: Text(
                                          '${(percent * 100).toStringAsFixed(0)}%',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        progressColor: isCompleted
                                            ? const Color.fromARGB(
                                                255, 104, 154, 105)
                                            : Color.fromARGB(
                                                255, 209, 198, 198),
                                        backgroundColor: const Color.fromARGB(
                                            255, 209, 198, 198),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              quiz.title,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                    color: Color(0xFF316E79),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                            Text(
                                              quiz.questions.length == 1
                                                  ? '${quiz.questions.length.toString()} question'
                                                  : '${quiz.questions.length.toString()}  questions',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                    color: Colors.grey.shade600,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 16),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              loading: () => ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: 6,
                itemBuilder: (_, __) => const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: QuizCardSkeleton(),
                ),
              ),
              error: (e, _) => Center(child: Text('Error loading scores: $e')),
            );
          },
          loading: () => ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 6,
            itemBuilder: (_, __) => const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: QuizCardSkeleton(),
            ),
          ),
          error: (e, _) => Center(child: Text('Error loading quizzes: $e')),
        ),
      ),
    );
  }
}
