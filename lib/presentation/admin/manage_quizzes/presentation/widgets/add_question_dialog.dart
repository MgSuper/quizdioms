import 'package:flutter/material.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/data/models/question_model.dart';

class AddQuestionDialog extends StatefulWidget {
  const AddQuestionDialog({super.key});

  @override
  State<AddQuestionDialog> createState() => _AddQuestionDialogState();
}

class _AddQuestionDialogState extends State<AddQuestionDialog> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final List<TextEditingController> _optionControllers =
      List.generate(4, (_) => TextEditingController());
  int _correctOptionIndex = 0;

  @override
  void dispose() {
    _questionController.dispose();
    for (var controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final options = _optionControllers
          .map((controller) => controller.text.trim())
          .toList();
      final question = QuestionModel(
        question: _questionController.text.trim(),
        options: options,
        answer: options[_correctOptionIndex],
      );
      Navigator.of(context).pop(question);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Question'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                cursorColor: Color(0xFF316E79),
                controller: _questionController,
                decoration: const InputDecoration(
                  labelText: 'Question',
                  labelStyle: TextStyle(
                    color: Color(0xFF316E79),
                  ),
                  floatingLabelStyle: TextStyle(
                    color: Color(0xFF316E79),
                  ),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter a question' : null,
              ),
              const SizedBox(height: 10),
              ...List.generate(4, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    cursorColor: Color(0xFF316E79),
                    controller: _optionControllers[index],
                    decoration: InputDecoration(
                      labelText: 'Option ${index + 1}',
                      labelStyle: TextStyle(
                        color: Color(0xFF316E79),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xFF316E79),
                      ),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Enter an option'
                        : null,
                  ),
                );
              }),
              const SizedBox(height: 10),
              DropdownButtonFormField<int>(
                value: _correctOptionIndex,
                decoration: const InputDecoration(
                  labelText: 'Correct Option',
                  labelStyle: TextStyle(
                    color: Color(0xFF316E79),
                  ),
                  floatingLabelStyle: TextStyle(
                    color: Color(0xFF316E79),
                  ),
                ),
                items: List.generate(4, (index) {
                  return DropdownMenuItem(
                    value: index,
                    child: Text(
                      'Option ${index + 1}',
                      style: TextStyle(
                        color: Color(0xFF316E79),
                      ),
                    ),
                  );
                }),
                onChanged: (value) {
                  setState(() {
                    _correctOptionIndex = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Color(0xFF316E79),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text(
            'Add',
            style: TextStyle(
              color: Color(0xFF316E79),
            ),
          ),
        ),
      ],
    );
  }
}
