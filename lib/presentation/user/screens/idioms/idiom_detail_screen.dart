import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/data/models/idioms.dart';
import 'package:quizdioms/presentation/user/navigation/responsive_wrapper.dart';
import 'package:quizdioms/presentation/user/screens/providers/learned_idiom_provider.dart';

class IdiomDetailScreen extends ConsumerStatefulWidget {
  final IdiomGroup group;

  const IdiomDetailScreen({super.key, required this.group});

  @override
  ConsumerState<IdiomDetailScreen> createState() => _IdiomDetailScreenState();
}

class _IdiomDetailScreenState extends ConsumerState<IdiomDetailScreen> {
  bool _isSubmitting = false;
  final PageController _pageController = PageController(viewportFraction: 0.75);
  double _currentPage = 0;

  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _handleMarkAsLearned() async {
    setState(() => _isSubmitting = true);
    final repo = ref.read(learnedIdiomRepoProvider);
    await repo.markAsLearned(widget.group.id);
    ref.invalidate(isGroupLearnedProvider(widget.group.id));
    setState(() => _isSubmitting = false);
  }

  Future<void> speak(String text) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1.0); // optional
    await flutterTts.setSpeechRate(0.45); // slower pace
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    final groupId = widget.group.id;
    final idioms = widget.group.idioms;
    final learnedAsync = ref.watch(isGroupLearnedProvider(groupId));

    final isWeb = MediaQuery.of(context).size.width >= 640;
    final padding = isWeb
        ? const EdgeInsets.symmetric(horizontal: 24)
        : const EdgeInsets.symmetric(horizontal: 16);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF316E79),
            Color(0xFF88A6AA),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: AppBar(
                centerTitle: false,
                title: Padding(
                  padding: padding,
                  child: Text(widget.group.groupName),
                ),
                backgroundColor: Colors.transparent,
                actions: [
                  Padding(
                    padding: padding,
                    child: learnedAsync.when(
                      data: (isLearned) {
                        return IconButton(
                          onPressed: isLearned || _isSubmitting
                              ? null
                              : _handleMarkAsLearned,
                          icon: Icon(
                            isLearned
                                ? Icons.check_circle
                                : Icons.add_circle_outline,
                            color: isLearned ? Colors.teal : Colors.white,
                          ),
                          tooltip:
                              isLearned ? 'Already learned' : 'Mark as learned',
                        );
                      },
                      loading: () => const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      error: (e, _) =>
                          const Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: ResponsiveWrapper(
          child: PageView.builder(
            itemCount: idioms.length,
            controller: _pageController,
            itemBuilder: (context, index) {
              final idiom = idioms[index];
              final scale =
                  (1 - (_currentPage - index).abs() * 0.1).clamp(0.9, 1.0);

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 100, horizontal: 16),
                child: Transform.scale(
                  scale: scale,
                  child: FlipCard(
                    speed: 600,
                    front: _buildGlassCard(
                      title: 'Idiom',
                      content: idiom.text,
                      gradientColors: [Color(0xFF316E79), Color(0xFF88A6AA)],
                    ),
                    back: _buildBackGlassCard(
                      title: idiom.meaning,
                      content: idiom.usage,
                      gradientColors: [Color(0xFF88A6AA), Color(0xFF316E79)],
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

  Widget _buildGlassCard({
    required String title,
    required String content,
    required List<Color> gradientColors,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(15),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.white.withAlpha(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tab to reveal the meaning',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      color: Colors.white,
                      fontSize: 12.0),
                ),
              ],
            ),
            // const Spacer(),
            const SizedBox(height: 16),
            Text(
              '"$content"',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackGlassCard({
    required String title,
    required String content,
    required List<Color> gradientColors,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(15),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.white.withAlpha(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Meaning',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 8),
                Text(title,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith()),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Usage',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                              color: Colors.white,
                            ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.volume_up, color: Colors.white),
                      tooltip: 'Listen',
                      onPressed: () => speak(content),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('"$content"',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
