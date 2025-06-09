import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/providers/theme_mode_provider.dart';
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

    final themeModeAsync = ref.watch(themeModeProvider);
    final themeMode = themeModeAsync.value ?? ThemeMode.system;
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ResponsiveWrapper(
        child: Column(
          children: [
            if (!state.isLoading && state.totalPages > 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  state.totalPages,
                  (index) => Padding(
                    padding: index == 0
                        ? const EdgeInsets.only(left: 16.0)
                        : EdgeInsets.zero,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (index + 1 == state.currentPage)
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
              ),
            Expanded(
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.items.isEmpty
                      ? const Center(child: Text('No phrases found'))
                      : ListView.builder(
                          padding: isWeb
                              ? EdgeInsets.zero
                              : const EdgeInsets.all(16),
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
                                        color: isDark
                                            ? Colors.white
                                            : Color(0xFF316E79),
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
                                trailing: Icon(
                                  Icons.check_circle,
                                  color: (isLearned && isDark)
                                      ? Colors.white
                                      : (isLearned && !isDark)
                                          ? Color(0xFF316E79)
                                          : (!isLearned && isDark)
                                              ? Colors.grey.shade700
                                              : Colors.grey.shade700,
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
