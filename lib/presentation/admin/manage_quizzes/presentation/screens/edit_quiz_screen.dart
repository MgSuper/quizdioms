import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/entities/question.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/entities/quiz.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/presentation/providers/quiz_controller.dart';

class EditQuizScreen extends ConsumerStatefulWidget {
  final Quiz quiz;

  const EditQuizScreen({super.key, required this.quiz});

  @override
  ConsumerState<EditQuizScreen> createState() => _EditQuizScreenState();
}

class _EditQuizScreenState extends ConsumerState<EditQuizScreen> {
  late TextEditingController _titleController;
  late List<Question> _questions;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.quiz.title);
    _questions = List<Question>.from(widget.quiz.questions);
  }

  void _updateQuestion(
      int index, String questionText, List<String> options, String answer) {
    setState(() {
      _questions[index] = _questions[index].copyWith(
        question: questionText,
        options: options,
        answer: answer,
      );
    });
  }

  void _submit() {
    final updatedQuiz = widget.quiz.copyWith(
      title: _titleController.text.trim(),
      questions: _questions,
    );

    ref.read(quizControllerProvider.notifier).updateQuiz(updatedQuiz);
    Navigator.pop(context);
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
          title: const Text('Edit Quiz'),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _submit,
            ),
          ],
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _questions.length,
          itemBuilder: (context, index) {
            final question = _questions[index];
            final questionController =
                TextEditingController(text: question.question);
            final optionControllers = question.options
                .map((o) => TextEditingController(text: o))
                .toList();
            final answerController =
                TextEditingController(text: question.answer);

            return Card(
              margin: const EdgeInsets.only(bottom: 24),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: questionController,
                      cursorColor: Color(0xFF316E79),
                      style: const TextStyle(
                        color: Color(0xFF316E79),
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Question',
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...List.generate(4, (optIdx) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                          controller: optionControllers[optIdx],
                          cursorColor: Color(0xFF316E79),
                          style: const TextStyle(
                            color: Color(0xFF316E79),
                          ),
                          decoration: InputDecoration(
                            labelText: 'Option ${optIdx + 1}',
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 8),
                    TextField(
                      controller: answerController,
                      cursorColor: Color(0xFF316E79),
                      style: const TextStyle(
                        color: Color(0xFF316E79),
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Answer',
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        final updatedOptions = optionControllers
                            .map((e) => e.text.trim())
                            .toList();
                        _updateQuestion(index, questionController.text.trim(),
                            updatedOptions, answerController.text.trim());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Question updated')),
                        );
                      },
                      child: const Text(
                        'Update Question',
                        style: TextStyle(
                          color: Color(0xFF316E79),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
