import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/admin/manage_phrases/data/models/phrase_group_model.dart';
import 'package:quizdioms/presentation/admin/manage_phrases/data/models/phrase_model.dart';
import 'package:quizdioms/presentation/admin/manage_phrases/providers/phrase_group_providers.dart';
import 'package:quizdioms/presentation/admin/manage_phrases/widgets/phrase_dialog.dart';
import '../controllers/phrase_group_list_controller.dart';

class AddNewPhrasesScreen extends ConsumerStatefulWidget {
  final PhraseGroupModel? group;

  const AddNewPhrasesScreen({super.key, this.group});

  @override
  ConsumerState<AddNewPhrasesScreen> createState() =>
      _AddNewPhrasesScreenState();
}

class _AddNewPhrasesScreenState extends ConsumerState<AddNewPhrasesScreen> {
  late TextEditingController groupNameController;
  List<PhraseModel> phrases = [];

  @override
  void initState() {
    super.initState();
    groupNameController =
        TextEditingController(text: widget.group?.groupName ?? '');
    phrases = widget.group?.phrases ?? [];
  }

  void saveGroup() {
    final model = PhraseGroupModel(
      id: widget.group?.id,
      groupName: groupNameController.text.trim(),
      createdAt: widget.group?.createdAt ?? DateTime.now(),
      phrases: phrases,
    );

    if (widget.group == null) {
      ref.read(addPhraseGroupProvider.notifier).add(model);
    } else {
      ref.read(updatePhraseGroupProvider.notifier).update(model);
    }

    Navigator.pop(context);
  }

  void openDialog([PhraseModel? phrase]) async {
    final result = await showDialog<PhraseModel>(
      context: context,
      builder: (_) => PhraseDialog(existing: phrase),
    );

    if (result != null) {
      setState(() {
        if (phrase != null) {
          final index = phrases.indexOf(phrase);
          phrases[index] = result;
        } else {
          phrases.add(result);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          title: Text(widget.group == null ? 'Add Group' : 'Edit Group'),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: saveGroup,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: groupNameController,
                decoration: const InputDecoration(labelText: 'Group Name'),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: phrases.length,
                  itemBuilder: (_, index) {
                    final phrase = phrases[index];
                    return ListTile(
                      title: Text(phrase.phrase),
                      subtitle: Text(phrase.meaning),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => openDialog(phrase),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                phrases.removeAt(index);
                              });
                            },
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Add Phrase'),
                onPressed: () => openDialog(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
