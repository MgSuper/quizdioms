import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/admin/manage_phrases/presentations/add_new_phrases_screen.dart';
import 'package:quizdioms/presentation/admin/manage_phrases/providers/phrase_group_providers.dart';

class ManagePhrasesScreen extends ConsumerStatefulWidget {
  const ManagePhrasesScreen({super.key});

  @override
  ConsumerState<ManagePhrasesScreen> createState() =>
      _ManagePhrasesScreenState();
}

class _ManagePhrasesScreenState extends ConsumerState<ManagePhrasesScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger first fetch
    Future.microtask(() {
      ref.read(phraseGroupListControllerProvider.notifier).fetchNext();
    });
  }

  @override
  Widget build(BuildContext context) {
    final groups = ref.watch(phraseGroupListControllerProvider);

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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Manage Phrase Groups'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddNewPhrasesScreen(),
                  ),
                );
              },
            )
          ],
        ),
        body: groups.isEmpty
            ? const Center(child: Text('No phrase groups yet'))
            : ListView.builder(
                itemCount: groups.length,
                itemBuilder: (_, index) {
                  final group = groups[index];
                  return ListTile(
                    title: Text(group.groupName),
                    subtitle: Text('${group.phrases.length} phrases'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        ref
                            .read(deletePhraseGroupProvider.notifier)
                            .delete(group.id!);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddNewPhrasesScreen(group: group),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
