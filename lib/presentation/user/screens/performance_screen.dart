import 'package:flutter/material.dart';
import 'package:quizdioms/presentation/user/navigation/responsive_wrapper.dart';
import 'package:quizdioms/presentation/user/widgets/user_app_bar.dart';

class PerformanceScreen extends StatelessWidget {
  const PerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const UserAppBar(title: 'Performance'),
      body: ResponsiveWrapper(
        child: const Center(
          child: Text('Coming soon'),
        ),
      ),
    );
  }
}
