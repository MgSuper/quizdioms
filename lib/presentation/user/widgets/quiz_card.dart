import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:quizdioms/presentation/admin/manage_quizzes/domain/entities/quiz.dart';

class QuizCard extends StatelessWidget {
  final Quiz quiz;
  final double correctPercent;

  const QuizCard({
    super.key,
    required this.quiz,
    required this.correctPercent,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(quiz.title),
        trailing: correctPercent > 0
            ? CircleAvatar(
                radius: 24,
                backgroundColor: Colors.green,
                child: Text(
                  '${(correctPercent * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(color: Colors.white),
                ),
              )
            : const Icon(Icons.chevron_right),
        onTap: () {
          context.push('/user/quiz/attempt', extra: quiz);
        },
      ),
    );
  }
}
