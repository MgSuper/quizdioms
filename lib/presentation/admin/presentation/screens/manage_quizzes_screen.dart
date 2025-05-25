import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/routes/app_router.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/presentation/providers/quiz_controller.dart';

class ManageQuizzesScreen extends ConsumerWidget {
  const ManageQuizzesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizControllerProvider);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF316E79),
            Color(0xFF88A6AA),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Quizzes'),
          centerTitle: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                ref
                    .read(goRouterProvider)
                    .push('/admin/manage-quizzes/add-quiz');
              },
            ),
          ],
        ),
        body: quizState.when(
          data: (quizzes) {
            if (quizzes.isEmpty) {
              return const Center(child: Text('No quizzes found.'));
            }
            return ListView.builder(
              itemCount: quizzes.length,
              itemBuilder: (context, index) {
                final quiz = quizzes[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(
                      quiz.title,
                      style: TextStyle(
                        color: Color(0xFF316E79),
                      ),
                    ),
                    subtitle: Text(
                      '${quiz.questions.length} question(s)',
                      style: TextStyle(
                        color: Color(0xFF316E79),
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Color(0xFF316E79),
                          ),
                          onPressed: () {
                            ref.read(goRouterProvider).push(
                                  '/admin/manage-quizzes/edit-quiz',
                                  extra: quiz,
                                );

                            // You can navigate to edit screen and pass `quiz`
                            // You may push to a screen like /admin/manage-quizzes/edit?quizId=...
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete Quiz'),
                                content: const Text(
                                    'Are you sure you want to delete this quiz?'),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: const Text('Cancel')),
                                  ElevatedButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: const Text('Delete')),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              await ref
                                  .read(quizControllerProvider.notifier)
                                  .deleteQuiz(quiz.id);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}
