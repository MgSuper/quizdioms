import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/entities/quiz.dart';
import 'package:confetti/confetti.dart';
import 'package:quizdioms/presentation/user/navigation/responsive_wrapper.dart';
import 'package:quizdioms/presentation/user/widgets/user_app_bar.dart';

class QuizAttemptScreen extends ConsumerStatefulWidget {
  final Quiz quiz;
  const QuizAttemptScreen({super.key, required this.quiz});

  @override
  ConsumerState<QuizAttemptScreen> createState() => _QuizAttemptScreenState();
}

class _QuizAttemptScreenState extends ConsumerState<QuizAttemptScreen> {
  int currentIndex = 0;
  String? selectedOption;
  bool? isCorrect;
  int correctAnswers = 0;

  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _submitAnswer() {
    final question = widget.quiz.questions[currentIndex];
    setState(() {
      isCorrect = selectedOption == question.answer;
      if (isCorrect!) correctAnswers++;
    });
  }

  Future<void> _nextQuestion() async {
    if (currentIndex < widget.quiz.questions.length - 1) {
      setState(() {
        currentIndex++;
        selectedOption = null;
        isCorrect = null;
      });
    } else {
      _confettiController.play(); // 🎉 Confetti

      await markQuizAsCompleted(widget.quiz.id);
      await saveQuizResult(
        quizId: widget.quiz.id,
        correctCount: correctAnswers,
        totalQuestions: widget.quiz.questions.length,
      );

      if (!mounted) return;
      context.go(
        '/user/quiz/result?correctAnswers=$correctAnswers',
        extra: widget.quiz,
      );
    }
  }

  Future<void> markQuizAsCompleted(String quizId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      await userDoc.update({
        'completedQuizzes': FieldValue.arrayUnion([quizId]),
      });
    }
  }

  Future<void> saveQuizResult({
    required String quizId,
    required int correctCount,
    required int totalQuestions,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final score = ((correctAnswers / totalQuestions) * 100).round();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('quizResults')
        .doc(quizId)
        .set({
      'score': score,
      'correctCount': correctCount,
      'totalQuestions': totalQuestions,
      'completedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.quiz.questions[currentIndex];

    final isWeb = MediaQuery.of(context).size.width >= 640;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: UserAppBar(title: widget.quiz.title),
      body: ResponsiveWrapper(
        child: Padding(
          padding: isWeb
              ? EdgeInsets.zero
              : const EdgeInsets.symmetric(horizontal: 16),
          child: Stack(
            children: [
              // 🎉 Confetti
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  colors: const [
                    Colors.yellow,
                    Colors.blue,
                    Colors.pink,
                    Colors.green
                  ],
                ),
              ),

              SingleChildScrollView(
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LinearProgressIndicator(
                        value:
                            (currentIndex + 1) / widget.quiz.questions.length,
                        backgroundColor: Colors.white24,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.greenAccent,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Question ${currentIndex + 1} of ${widget.quiz.questions.length}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          'Q: ${question.question}',
                          key: ValueKey(question.question),
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...question.options.map((option) {
                        final isSelected = selectedOption == option;
                        final isCorrectOption = option == question.answer;

                        Color? tileColor;
                        if (isCorrect != null) {
                          tileColor = isCorrectOption
                              ? Colors.greenAccent
                              : (isSelected ? Colors.red[100] : null);
                        } else if (isSelected) {
                          tileColor = Colors.white38;
                        }

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: tileColor ?? Colors.white24,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? Colors.white : Colors.white60,
                              width: 2,
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              option,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            onTap: isCorrect == null
                                ? () => setState(() => selectedOption = option)
                                : null,
                          ),
                        );
                      }),
                      const SizedBox(height: 16),
                      if (isCorrect == null)
                        Padding(
                          padding: kIsWeb
                              ? EdgeInsets.zero
                              : const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ElevatedButton(
                            onPressed:
                                selectedOption == null ? null : _submitAnswer,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: Colors.greenAccent,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 56),
                            ),
                            child: const Text(
                              'Submit Answer',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      else
                        Column(
                          children: [
                            Text(
                              isCorrect! ? 'Correct! 🎉' : 'Wrong! ❌',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color:
                                        isCorrect! ? Colors.white : Colors.red,
                                  ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _nextQuestion,
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.zero,
                                backgroundColor: Colors.greenAccent,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 56),
                              ),
                              child: Text(
                                currentIndex < widget.quiz.questions.length - 1
                                    ? 'Next Question'
                                    : 'Finish',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
