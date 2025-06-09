import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/providers/theme_mode_provider.dart';
import 'package:quizdioms/presentation/user/screens/idioms/idiom_screen.dart';
import 'package:quizdioms/presentation/user/screens/phrases/phrase_screen.dart';
import 'package:quizdioms/presentation/user/widgets/user_app_bar.dart';

class LearningScreen extends ConsumerStatefulWidget {
  const LearningScreen({super.key});

  @override
  ConsumerState<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends ConsumerState<LearningScreen> {
  bool showPhrases = true;

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width >= 640;
    final padding = isWeb
        ? const EdgeInsets.symmetric(horizontal: 36)
        : const EdgeInsets.symmetric(horizontal: 20);

    final themeModeAsync = ref.watch(themeModeProvider);
    final themeMode = themeModeAsync.value ?? ThemeMode.system;
    final isDark = themeMode == ThemeMode.dark;
    return Scaffold(
      appBar: const UserAppBar(title: 'Learning'),
      backgroundColor: Colors.transparent,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: padding,
                child: ToggleButtons(
                  isSelected: [showPhrases, !showPhrases],
                  onPressed: (index) {
                    setState(() {
                      showPhrases = index == 0;
                    });
                  },
                  borderRadius: BorderRadius.circular(12),
                  selectedColor: isDark ? Colors.black : Colors.white,
                  fillColor: isDark ? Colors.white : const Color(0xFF316E79),
                  color: isDark ? Colors.white : Colors.black,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Phrases',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Idioms',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: showPhrases ? const PhraseScreen() : const IdiomScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
