import 'package:flutter/material.dart';
import 'package:quizdioms/presentation/user/widgets/user_app_bar.dart';

class PhraseScreen extends StatelessWidget {
  const PhraseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const UserAppBar(title: 'Phrases'),
      body: const Center(
        child: Text('Coming soon'),
      ),
    );
  }
}
