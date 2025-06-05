import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/user/screens/phrases/providers/user_phrase_group_providers.dart';
import 'package:quizdioms/presentation/user/screens/phrases/providers/user_phrase_metadata_providers.dart';
import 'phrase_group_detail_screen.dart';

class PhraseScreen extends ConsumerWidget {
  const PhraseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userPhraseGroupListControllerProvider);
    final controller = ref.read(userPhraseGroupListControllerProvider.notifier);
    final learnedIds = ref.watch(userLearnedPhraseControllerProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.items.isEmpty
                    ? const Center(child: Text('No phrases found'))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 4),
                        itemCount: state.items.length,
                        itemBuilder: (_, index) {
                          final group = state.items[index];
                          final isLearned = learnedIds.contains(group.id);

                          return ListTile(
                            title: Text(group.groupName),
                            subtitle: Text('${group.phrases.length} phrases'),
                            trailing: isLearned
                                ? const Icon(Icons.check_circle,
                                    color: Colors.green)
                                : null,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      PhraseGroupDetailScreen(group: group),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
          if (!state.isLoading && state.totalPages > 1)
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  state.totalPages,
                  (index) {
                    final pageNumber = index + 1;
                    final isSelected = pageNumber == state.currentPage;
                    return GestureDetector(
                      onTap: () => controller.goToPage(pageNumber),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue : Colors.white,
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '$pageNumber',
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
