import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quizdioms/core/utils/helper.dart';
import 'package:quizdioms/presentation/user/navigation/responsive_wrapper.dart';
import 'package:quizdioms/presentation/user/screens/providers/learned_idiom_provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:quizdioms/presentation/user/screens/providers/paginated_idiom_controller.dart';

class IdiomScreen extends ConsumerStatefulWidget {
  const IdiomScreen({super.key});

  @override
  ConsumerState<IdiomScreen> createState() => _IdiomScreenState();
}

class _IdiomScreenState extends ConsumerState<IdiomScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(paginatedIdiomProvider.notifier).fetchNext(); // Initial load
    _scrollController.addListener(() {
      final controller = ref.read(paginatedIdiomProvider.notifier);
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          !controller.isLoading &&
          controller.hasMore) {
        controller.fetchNext();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(paginatedIdiomProvider.notifier);
    final groups = ref.watch(paginatedIdiomProvider);

    final isWeb = MediaQuery.of(context).size.width >= 640;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ResponsiveWrapper(
        child: groups.isEmpty && !controller.hasMore
            ? const Center(child: Text('No idioms available yet.'))
            : AnimationLimiter(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: isWeb ? EdgeInsets.zero : const EdgeInsets.all(16),
                  itemCount: groups.length + (controller.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == groups.length) {
                      return const Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

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
                                context.push('/user/idioms/detail',
                                    extra: group);
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
                                                .bodyMedium
                                                ?.copyWith(
                                                  color: Color(0xFF316E79),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            formatDateTime(group.createdAt),
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall
                                                ?.copyWith(
                                                  color: Colors.grey.shade600,
                                                  fontWeight: FontWeight.w600,
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
                                            Icons.check_circle,
                                            color: isLearned
                                                ? Color(0xFF316E79)
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
