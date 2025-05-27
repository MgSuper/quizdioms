import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quizdioms/core/utils/helper.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/presentation/providers/idiom_list_provider.dart';
import 'package:quizdioms/presentation/user/navigation/responsive_wrapper.dart';
import 'package:quizdioms/presentation/user/screens/providers/learned_idiom_provider.dart';
import 'package:quizdioms/presentation/user/widgets/user_app_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class IdiomScreen extends ConsumerWidget {
  const IdiomScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idiomGroups = ref.watch(idiomGroupListProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const UserAppBar(title: 'Idioms'),
      body: ResponsiveWrapper(
        child: idiomGroups.when(
          data: (groups) {
            if (groups.isEmpty) {
              return const Center(child: Text('No idioms available yet.'));
            }

            return AnimationLimiter(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  final group = groups[index];

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
                              context.push('/user/idioms/detail', extra: group);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.menu_book,
                                      color: Color(0xFF316E79)),
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
                                              .titleMedium
                                              ?.copyWith(
                                                color: Color(0xFF316E79),
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          formatDateTime(group.createdAt),
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Consumer(
                                    builder: (context, ref, _) {
                                      final learnedAsync = ref.watch(
                                          isGroupLearnedProvider(group.id));
                                      return learnedAsync.when(
                                        data: (isLearned) => Icon(
                                          isLearned
                                              ? Icons.check_circle
                                              : Icons.add_circle_outline,
                                          color: isLearned
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                        loading: () => const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
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
            );
          },
          loading: () => ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 6,
            itemBuilder: (_, __) => const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: SkeletonPlaceholder(),
            ),
          ),
          error: (e, _) => Center(child: Text('Error loading idioms: $e')),
        ),
      ),
    );
  }
}

class SkeletonPlaceholder extends StatelessWidget {
  const SkeletonPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: Colors.grey.shade300.withAlpha(3),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
