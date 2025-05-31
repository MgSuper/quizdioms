import 'package:flutter/material.dart';
import 'package:quizdioms/presentation/user/navigation/responsive_wrapper.dart';

class PhraseScreen extends StatelessWidget {
  const PhraseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ResponsiveWrapper(
        child: const Center(
          child: Text('Coming soon'),
        ),
      ),
    );
  }
}
