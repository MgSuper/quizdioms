import 'package:flutter/material.dart';
import 'package:quizdioms/presentation/admin/manage_phrases/data/models/phrase_model.dart';

class PhraseDialog extends StatefulWidget {
  final PhraseModel? existing;

  const PhraseDialog({super.key, this.existing});

  @override
  State<PhraseDialog> createState() => _PhraseDialogState();
}

class _PhraseDialogState extends State<PhraseDialog> {
  late TextEditingController phraseController;
  late TextEditingController meaningController;
  late TextEditingController example1Controller;
  late TextEditingController example2Controller;

  @override
  void initState() {
    super.initState();
    phraseController =
        TextEditingController(text: widget.existing?.phrase ?? '');
    meaningController =
        TextEditingController(text: widget.existing?.meaning ?? '');
    example1Controller =
        TextEditingController(text: widget.existing?.example1 ?? '');
    example2Controller =
        TextEditingController(text: widget.existing?.example2 ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.existing == null ? 'Add Phrase' : 'Edit Phrase'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
                controller: phraseController,
                decoration: const InputDecoration(labelText: 'Phrase')),
            TextField(
                controller: meaningController,
                decoration: const InputDecoration(labelText: 'Meaning')),
            TextField(
                controller: example1Controller,
                decoration: const InputDecoration(labelText: 'Example 1')),
            TextField(
                controller: example2Controller,
                decoration: const InputDecoration(labelText: 'Example 2')),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            final phrase = PhraseModel(
              phrase: phraseController.text.trim(),
              meaning: meaningController.text.trim(),
              example1: example1Controller.text.trim(),
              example2: example2Controller.text.trim(),
            );
            Navigator.pop(context, phrase);
          },
          child: const Text('Save'),
        )
      ],
    );
  }
}
