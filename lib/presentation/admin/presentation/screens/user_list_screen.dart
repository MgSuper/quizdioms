import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPerformanceScreen extends ConsumerWidget {
  const UserPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Userlist'),
        centerTitle: false,
      ),
    );
  }
}
