import 'package:confetti/confetti.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/entities/quiz.dart';
import 'package:quizdioms/presentation/user/navigation/responsive_wrapper.dart';
import 'package:quizdioms/presentation/user/screens/providers/paginated_quiz_controller.dart';
import 'package:quizdioms/presentation/user/screens/providers/user_quiz_score_provider.dart';
import 'package:quizdioms/presentation/user/widgets/user_app_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class QuizzScreen extends ConsumerStatefulWidget {
  const QuizzScreen({super.key});

  @override
  ConsumerState<QuizzScreen> createState() => _QuizzScreenState();
}

class _QuizzScreenState extends ConsumerState<QuizzScreen> {
  final _scrollController = ScrollController();
  late ConfettiController _confettiController;
  // int? _unlockAnimationIndex;
  // Map<String, double> _previousScores = {};

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));

    // ref.read(userQuizScoreProvider).whenData((scoreMap) {
    //   _previousScores = Map.from(scoreMap);
    // });

    _scrollController.addListener(() {
      final controller = ref.read(paginatedQuizProvider.notifier);
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          !controller.isLoading &&
          controller.hasMore) {
        controller.fetchNext();
      }
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(paginatedQuizProvider.notifier);
    final quizzes = ref.watch(paginatedQuizProvider);
    final scoreMapAsync = ref.watch(userQuizScoreProvider);

    return Scaffold(
      appBar: const UserAppBar(title: 'Quizzes'),
      backgroundColor: Colors.transparent,
      body: ResponsiveWrapper(
        child: scoreMapAsync.when(
          data: (scoreMap) {
            return ListView.builder(
              controller: _scrollController,
              padding: kIsWeb ? EdgeInsets.zero : const EdgeInsets.all(16),
              itemCount: quizzes.length + (controller.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == quizzes.length) {
                  return controller.hasMore
                      ? const Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : const SizedBox.shrink();
                }

                final quiz = quizzes[index];
                final percent = scoreMap[quiz.id] ?? 0.0;
                final isCompleted = percent >= 0.8;

                int lastUnlockedIndex = -1;
                for (int i = 0; i < quizzes.length; i++) {
                  final score = scoreMap[quizzes[i].id] ?? 0.0;
                  if (score >= 0.8) {
                    lastUnlockedIndex = i;
                  } else {
                    break;
                  }
                }
                final isLocked = index > lastUnlockedIndex + 1;

                return Stack(children: [
                  _buildQuizCard(
                      context, quiz, index, percent, isCompleted, isLocked),
                ]);
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }

  Widget _buildQuizCard(BuildContext context, Quiz quiz, int index,
      double percent, bool isCompleted, bool isLocked) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 500),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Opacity(
            opacity: isLocked ? 0.5 : 1.0,
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: isLocked
                    ? null
                    : () => context.push('/user/quiz/attempt', extra: quiz),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      CircularPercentIndicator(
                        radius: 30.0,
                        lineWidth: 6.0,
                        animation: true,
                        percent: percent,
                        center: Text(
                          '${(percent * 100).toStringAsFixed(0)}%',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: const Color(0xFF316E79),
                                  ),
                        ),
                        progressColor: isCompleted
                            ? const Color(0xFF316E79)
                            : const Color(0xFF88A6AA),
                        backgroundColor: const Color(0xFF88A6AA),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              quiz.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: const Color(0xFF316E79),
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              '${quiz.questions.length} question${quiz.questions.length == 1 ? '' : 's'}',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      isLocked
                          ? Animate(
                              effects: [
                                FadeEffect(duration: 300.ms),
                                ScaleEffect(duration: 300.ms)
                              ],
                              child: const Tooltip(
                                message: 'Score at least 80% to unlock.',
                                child: Icon(Icons.lock_outline, size: 20),
                              ),
                            )
                          : const Icon(Icons.arrow_forward_ios_rounded,
                              size: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
