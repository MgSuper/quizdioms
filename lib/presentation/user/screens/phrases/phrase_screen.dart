import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/user/navigation/responsive_wrapper.dart';
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

    final isWeb = MediaQuery.of(context).size.width >= 640;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ResponsiveWrapper(
        child: Column(
          children: [
            if (!state.isLoading && state.totalPages > 1)
              Container(
                color: Colors.transparent,
                padding: isWeb
                    ? EdgeInsets.zero
                    : const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    state.totalPages,
                    (index) {
                      final pageNumber = index + 1;
                      final isSelected = pageNumber == state.currentPage;
                      return GestureDetector(
                        onTap: () => controller.goToPage(pageNumber),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: isWeb
                              ? EdgeInsets.zero
                              : const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color:
                                isSelected ? Color(0xFF316E79) : Colors.white,
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(50),
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
            Expanded(
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.items.isEmpty
                      ? const Center(child: Text('No phrases found'))
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: state.items.length,
                          itemBuilder: (_, index) {
                            final group = state.items[index];
                            final isLearned = learnedIds.contains(group.id);

                            return Card(
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: ListTile(
                                title: Text(
                                  group.groupName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Color(0xFF316E79),
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                subtitle: Text(
                                  '${group.phrases.length} phrases',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                trailing: isLearned
                                    ? const Icon(
                                        Icons.check_circle,
                                        color: Color(0xFF316E79),
                                      )
                                    : const Icon(
                                        Icons.check_circle,
                                        color: Colors.grey,
                                      ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          PhraseGroupDetailScreen(group: group),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
