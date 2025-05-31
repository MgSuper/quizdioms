import 'package:flutter/material.dart';
import 'package:quizdioms/presentation/user/screens/idioms/idiom_screen.dart';
import 'package:quizdioms/presentation/user/screens/phrase_screen.dart';
import 'package:quizdioms/presentation/user/widgets/user_app_bar.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  bool showIdioms = true;

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ToggleButtons(
                  isSelected: [showIdioms, !showIdioms],
                  onPressed: (index) {
                    setState(() {
                      showIdioms = index == 0;
                    });
                  },
                  borderRadius: BorderRadius.circular(12),
                  selectedColor: Colors.white,
                  fillColor: const Color(0xFF316E79),
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('Idioms'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('Phrases'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: showIdioms ? const IdiomScreen() : const PhraseScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
