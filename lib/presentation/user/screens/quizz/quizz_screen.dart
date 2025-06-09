import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/entities/quiz.dart';
import 'package:quizdioms/presentation/providers/theme_mode_provider.dart';
import 'package:quizdioms/presentation/user/navigation/responsive_wrapper.dart';
import 'package:quizdioms/presentation/user/screens/quizz/models/paginated_quiz_state.dart';
import 'package:quizdioms/presentation/user/screens/quizz/providers/paginated_quiz_controller.dart';
import 'package:quizdioms/presentation/user/screens/quizz/providers/paginated_quiz_provider.dart';
import 'package:quizdioms/presentation/user/screens/quizz/providers/user_quiz_score_provider.dart';
import 'package:quizdioms/presentation/user/widgets/user_app_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class QuizzScreen extends ConsumerWidget {
  const QuizzScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizzes = ref.watch(paginatedQuizItemsProvider);

    final state = ref.watch(paginatedQuizControllerProvider);
    final quizController = ref.read(paginatedQuizControllerProvider.notifier);

    final scoreMapAsync = ref.watch(userQuizScoreProvider);

    final isWeb = MediaQuery.of(context).size.width >= 640;

    final themeModeAsync = ref.watch(themeModeProvider);
    final themeMode = themeModeAsync.value ?? ThemeMode.system;
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: const UserAppBar(title: 'Quizzes'),
      backgroundColor: Colors.transparent,
      body: ResponsiveWrapper(
        child: scoreMapAsync.when(
          data: (scoreMap) {
            return Column(
              children: [
                _buildPaginationControls(state, quizController, isDark),
                Expanded(
                  child: ListView.builder(
                      padding: isWeb
                          ? EdgeInsets.zero
                          : const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: quizzes.length,
                      itemBuilder: (context, index) {
                        final quiz = quizzes[index];
                        final percent = scoreMap[quiz.id] ?? 0.0;
                        final isCompleted = percent >= 0.8;

                        // Global index of the quiz
                        final globalIndex = (state.currentPage - 1) * 5 + index;

                        // Total number of completed quizzes
                        final unlockedCount =
                            scoreMap.values.where((v) => v >= 0.8).length;

                        // Lock if this quiz comes after the last completed one
                        final isLocked = globalIndex > unlockedCount;

                        return _buildQuizCard(
                          context,
                          quiz,
                          index,
                          percent,
                          isCompleted,
                          isLocked,
                          isDark,
                        );
                      }),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }

  Widget _buildPaginationControls(PaginatedQuizState state,
      PaginatedQuizController controller, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        state.totalPages,
        (index) => Padding(
          padding:
              index == 0 ? const EdgeInsets.only(left: 16.0) : EdgeInsets.zero,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: index + 1 == state.currentPage
                  ? Colors.white
                  : Colors.grey.shade400,
              minimumSize: const Size(36, 36),
              padding: EdgeInsets.zero,
            ),
            onPressed: () {
              controller.goToPage(index + 1);
            },
            child: Text(
              '${index + 1}',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizCard(BuildContext context, Quiz quiz, int index,
      double percent, bool isCompleted, bool isLocked, bool isDark) {
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
                                    color: isDark
                                        ? Colors.white
                                        : const Color(0xFF316E79),
                                  ),
                        ),
                        progressColor: (isCompleted && !isDark)
                            ? const Color(0xFF316E79)
                            : (isCompleted && isDark)
                                ? Colors.white
                                : (!isCompleted && isDark)
                                    ? Colors.white
                                    : const Color(0xFF88A6AA),
                        backgroundColor: isDark
                            ? Colors.grey.shade600
                            : const Color(0xFF88A6AA),
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
                                    color: isDark
                                        ? Colors.white
                                        : const Color(0xFF316E79),
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
