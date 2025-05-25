// lib/presentation/user/widgets/quiz_card_skeleton.dart

import 'package:flutter/material.dart';
import 'package:quizdioms/presentation/user/widgets/skeleton_loader.dart';

class QuizCardSkeleton extends StatelessWidget {
  const QuizCardSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            const SkeletonLoader(
              height: 60,
              width: 60,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SkeletonLoader(height: 16, width: 150),
                  SizedBox(height: 8),
                  SkeletonLoader(height: 14, width: 100),
                ],
              ),
            ),
            const SizedBox(width: 16),
            const SkeletonLoader(height: 16, width: 16),
          ],
        ),
      ),
    );
  }
}
