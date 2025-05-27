import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/presentation/providers/idiom_list_provider.dart';
import 'package:quizdioms/presentation/user/navigation/responsive_wrapper.dart';

class ManageIdiomsScreen extends ConsumerWidget {
  const ManageIdiomsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idiomGroups = ref.watch(idiomGroupListProvider);

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
          title: const Text('Manage Idioms'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                context.push('/admin/manage-idioms/add-idiom');
              },
            ),
          ],
        ),
        body: ResponsiveWrapper(
          child: idiomGroups.when(
            data: (groups) {
              if (groups.isEmpty) {
                return const Center(child: Text('No idiom groups yet.'));
              }

              return ListView.builder(
                itemCount: groups.length,
                itemBuilder: (_, index) {
                  final group = groups[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(
                        group.groupName,
                        style: TextStyle(
                          color: Color(0xFF316E79),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              context.push('/admin/manage-idioms/edit-idiom',
                                  extra: group);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                _confirmDelete(context, ref, group.id),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('Error: $e')),
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Idiom Group'),
        content: const Text('Are you sure you want to delete this group?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Delete')),
        ],
      ),
    );

    if (confirm == true) {
      await FirebaseFirestore.instance.collection('idioms').doc(id).delete();
      ref.invalidate(idiomGroupListProvider); // Refresh the list
    }
  }
}
