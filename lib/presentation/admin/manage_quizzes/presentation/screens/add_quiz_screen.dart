import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/data/models/question_model.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/data/models/quiz_model.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/presentation/providers/quiz_controller.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/presentation/widgets/add_question_dialog.dart';
import 'package:uuid/uuid.dart';

class AddQuizScreen extends ConsumerStatefulWidget {
  const AddQuizScreen({super.key});

  @override
  ConsumerState<AddQuizScreen> createState() => _AddQuizScreenState();
}

class _AddQuizScreenState extends ConsumerState<AddQuizScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final List<QuestionModel> _questions = [];

  void _addQuestion() async {
    final question = await showDialog<QuestionModel>(
      context: context,
      builder: (context) => const AddQuestionDialog(),
    );
    if (question != null) {
      setState(() {
        _questions.add(question);
      });
    }
  }

  void _submitQuiz() {
    if (_formKey.currentState!.validate() && _questions.isNotEmpty) {
      final quiz = QuizModel(
        id: const Uuid().v4(),
        title: _titleController.text.trim(),
        questions: _questions,
      );
      ref.read(quizControllerProvider.notifier).addQuiz(quiz.toEntity());
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one question.')),
      );
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
          title: const Text('Add Quiz'),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _submitQuiz,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  style: const TextStyle(color: Color(0xFFD8E2E4)),
                  controller: _titleController,
                  cursorColor: Color(0xFFD8E2E4),
                  decoration: const InputDecoration(labelText: 'Quiz Title'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter a title' : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.add,
                    color: Color(0xFF316E79),
                  ),
                  label: const Text(
                    'Add Question',
                    style: TextStyle(
                      color: Color(0xFF316E79),
                    ),
                  ),
                  onPressed: _addQuestion,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: _questions.length,
                    itemBuilder: (context, index) {
                      final q = _questions[index];
                      return ListTile(
                        title: Text(q.question),
                        subtitle: Text('Answer: ${q.answer}'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
