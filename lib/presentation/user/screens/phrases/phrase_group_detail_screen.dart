import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/admin/manage_phrases/data/models/phrase_group_model.dart';
import 'package:quizdioms/presentation/user/screens/phrases/providers/user_phrase_metadata_providers.dart';

class PhraseGroupDetailScreen extends ConsumerWidget {
  final PhraseGroupModel group;

  const PhraseGroupDetailScreen({super.key, required this.group});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final learnedController =
        ref.watch(userLearnedPhraseControllerProvider.notifier);
    final learnedIds = ref.watch(userLearnedPhraseControllerProvider);
    final isLearned = learnedIds.contains(group.id);

    final isWeb = MediaQuery.of(context).size.width >= 640;
    final padding = isWeb
        ? const EdgeInsets.symmetric(horizontal: 24)
        : const EdgeInsets.symmetric(horizontal: 16);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(group.groupName),
            centerTitle: false,
            actions: [
              IconButton(
                icon: Icon(
                  isLearned ? Icons.check_circle : Icons.check_circle_outline,
                  color: isLearned ? Color(0xFF316E79) : null,
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
        ),
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
              Text(
                'Phrase',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
              ),
              Text(
                phrase.phrase,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              Text(
                'Explanation',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
              ),
              Text(
                phrase.meaning,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              Text(
                'Example Usage 1',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
              ),
              Text(
                phrase.example1,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              Text(
                'Example Usage 2',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
              ),
              Text(
                phrase.example2,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          );
        },
      ),
    );
  }
}
