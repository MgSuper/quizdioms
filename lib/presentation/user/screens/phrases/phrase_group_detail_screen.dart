import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/admin/manage_phrases/data/models/phrase_group_model.dart';
import 'package:quizdioms/presentation/user/navigation/responsive_wrapper.dart';
import 'package:quizdioms/presentation/user/screens/phrases/providers/user_phrase_metadata_providers.dart';
import 'package:flutter_tts/flutter_tts.dart';

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
    final padding =
        isWeb ? const EdgeInsets.symmetric(horizontal: 24) : EdgeInsets.zero;
    final FlutterTts flutterTts = FlutterTts();

    Future<void> speak(String text) async {
      await flutterTts.setLanguage('en-US');
      await flutterTts.setPitch(1.0); // optional
      await flutterTts.setSpeechRate(0.45); // slower pace
      await flutterTts.speak(text);
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: AppBar(
              backgroundColor: Colors.transparent,
              title: Padding(
                padding: padding,
                child: Text(group.groupName),
              ),
              centerTitle: false,
              actions: [
                Padding(
                  padding: padding,
                  child: IconButton(
                    icon: Icon(
                      isLearned
                          ? Icons.check_circle
                          : Icons.check_circle_outline,
                      color: isLearned ? Colors.teal : null,
                    ),
                    tooltip:
                        isLearned ? 'Mark as Unlearned' : 'Mark as Learned',
                    onPressed: () {
                      if (isLearned) {
                        learnedController.unmarkAsLearned(group.id!);
                      } else {
                        learnedController.markAsLearned(group.id!);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ResponsiveWrapper(
        child: ListView.separated(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '"${phrase.phrase}"',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.volume_up, color: Colors.white),
                      tooltip: 'Listen',
                      onPressed: () => speak(phrase.phrase),
                    ),
                  ],
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
                  '"${phrase.meaning}"',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Example Usage 1',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.volume_up, color: Colors.white),
                      tooltip: 'Listen',
                      onPressed: () => speak(phrase.example1),
                    ),
                  ],
                ),
                Text(
                  '"${phrase.example1}"',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Example Usage 2',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.volume_up, color: Colors.white),
                      tooltip: 'Listen',
                      onPressed: () => speak(phrase.example2),
                    ),
                  ],
                ),
                Text(
                  '"${phrase.example2}"',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
