import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageQuotesScreen extends ConsumerWidget {
  const ManageQuotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotes'),
        centerTitle: false,
      ),
    );
  }
}
