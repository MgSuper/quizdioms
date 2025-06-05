import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/user/screens/phrases/controllers/user_learned_phrase_controller.dart';
import 'package:quizdioms/presentation/user/screens/phrases/providers/user_phrase_metadata_providers.dart';

import '../../../admin/manage_phrases/data/models/phrase_group_model.dart';

class PhraseGroupDetailScreen extends ConsumerWidget {
  final PhraseGroupModel group;

  const PhraseGroupDetailScreen({super.key, required this.group});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final learnedController =
        ref.watch(userLearnedPhraseControllerProvider.notifier);
    final learnedIds = ref.watch(userLearnedPhraseControllerProvider);
    final isLearned = learnedIds.contains(group.id);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(group.groupName),
        actions: [
          IconButton(
            icon: Icon(
              isLearned ? Icons.check_circle : Icons.check_circle_outline,
              color: isLearned ? Colors.green : null,
            ),
            tooltip: isLearned ? 'Mark as Unlearned' : 'Mark as Learned',
            onPressed: () {
              if (isLearned) {
                learnedController.unmarkAsLearned(group.id!);
              } else {
                learnedController.markAsLearned(group.id!);
              }
            },
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: group.phrases.length,
        separatorBuilder: (_, __) => const Divider(height: 32),
        itemBuilder: (_, index) {
          final phrase = group.phrases[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Phrase', style: labelStyle),
              Text(phrase.phrase, style: contentStyle),
              const SizedBox(height: 12),
              Text('Explanation', style: labelStyle),
              Text(phrase.meaning, style: contentStyle),
              const SizedBox(height: 12),
              Text('Example Usage 1', style: labelStyle),
              Text(phrase.example1, style: contentStyle),
              const SizedBox(height: 12),
              Text('Example Usage 2', style: labelStyle),
              Text(phrase.example2, style: contentStyle),
            ],
          );
        },
      ),
    );
  }

  TextStyle get labelStyle => const TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xFFD8E2E4),
        fontSize: 18,
        // decoration: TextDecoration.underline,
        // decorationColor: Colors.white,
      );

  TextStyle get contentStyle => const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontStyle: FontStyle.italic,
      );
}
