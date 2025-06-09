import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quizdioms/core/utils/helper.dart';
import 'package:quizdioms/presentation/providers/theme_mode_provider.dart';
import 'package:quizdioms/presentation/user/navigation/responsive_wrapper.dart';
import 'package:quizdioms/presentation/user/screens/idioms/models/paginated_idiom_state.dart';
import 'package:quizdioms/presentation/user/screens/idioms/providers/paginated_idiom_provider.dart';
import 'package:quizdioms/presentation/user/screens/idioms/providers/learned_idiom_provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:quizdioms/presentation/user/screens/idioms/providers/paginated_idiom_controller.dart';

class IdiomScreen extends ConsumerWidget {
  const IdiomScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(paginatedIdiomControllerProvider);
    final controller = ref.read(paginatedIdiomControllerProvider.notifier);
    final idiomGroups = ref.watch(paginatedIdiomItemsProvider);
    final isWeb = MediaQuery.of(context).size.width >= 640;

    final themeModeAsync = ref.watch(themeModeProvider);
    final themeMode = themeModeAsync.value ?? ThemeMode.system;
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ResponsiveWrapper(
        child: idiomGroups.isEmpty && !state.isLoading
            ? const Center(child: Text('No idioms available yet.'))
            : Column(
                children: [
                  _buildPaginationControls(state, controller, isDark),
                  Expanded(
                    child: AnimationLimiter(
                      child: ListView.builder(
                        padding:
                            isWeb ? EdgeInsets.zero : const EdgeInsets.all(16),
                        itemCount: idiomGroups.length,
                        itemBuilder: (context, index) {
                          final group = idiomGroups[index];

                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: Card(
                                  elevation: 6,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(16),
                                    onTap: () {
                                      context.push('/user/idioms/detail',
                                          extra: group);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(Icons.menu_book,
                                              color: isDark
                                                  ? Colors.white
                                                  : Color(0xFF316E79)),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  group.groupName,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        color: isDark
                                                            ? Colors.white
                                                            : Color(0xFF316E79),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  formatDateTime(
                                                      group.createdAt),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall
                                                      ?.copyWith(
                                                        color: Colors
                                                            .grey.shade600,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Consumer(
                                            builder: (context, ref, _) {
                                              final learnedAsync = ref.watch(
                                                  isGroupLearnedProvider(
                                                      group.id));
                                              return learnedAsync.when(
                                                data: (isLearned) => Icon(
                                                  Icons.check_circle,
                                                  color: (isLearned && isDark)
                                                      ? Colors.white
                                                      : (isLearned && !isDark)
                                                          ? Color(0xFF316E79)
                                                          : (!isLearned &&
                                                                  isDark)
                                                              ? Colors
                                                                  .grey.shade700
                                                              : Colors.grey
                                                                  .shade700,
                                                ),
                                                loading: () => const SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                          strokeWidth: 2),
                                                ),
                                                error: (_, __) => const Icon(
                                                    Icons.error,
                                                    color: Colors.red),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
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
      ),
    );
  }

  Widget _buildPaginationControls(
    PaginatedIdiomState state,
    PaginatedIdiomController controller,
    bool isDark,
  ) {
    return Row(
      children: List.generate(
        state.totalPages,
        (index) => Padding(
          padding:
              index == 0 ? const EdgeInsets.only(left: 16.0) : EdgeInsets.zero,
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
    );
  }
}
