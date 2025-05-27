import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/data/models/idioms.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/presentation/providers/idiom_controller.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/presentation/providers/idiom_list_provider.dart';
import 'package:quizdioms/presentation/user/navigation/responsive_wrapper.dart';

class AddIdiomsScreen extends ConsumerStatefulWidget {
  const AddIdiomsScreen({super.key});

  @override
  ConsumerState<AddIdiomsScreen> createState() => _AddIdiomsScreenState();
}

class _AddIdiomsScreenState extends ConsumerState<AddIdiomsScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _textControllers =
      List.generate(3, (_) => TextEditingController());
  final List<TextEditingController> _meaningControllers =
      List.generate(3, (_) => TextEditingController());
  final List<TextEditingController> _usageControllers =
      List.generate(3, (_) => TextEditingController());

  final _groupNameController = TextEditingController();

  @override
  void dispose() {
    for (final c in [
      ..._textControllers,
      ..._meaningControllers,
      ..._usageControllers,
      _groupNameController,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final idioms = List.generate(3, (i) {
      return Idiom(
        text: _textControllers[i].text.trim(),
        meaning: _meaningControllers[i].text.trim(),
        usage: _usageControllers[i].text.trim(),
      );
    });

    final controller = ref.read(idiomControllerProvider.notifier);
    await controller.submit(
      idioms: idioms,
      groupName: _groupNameController.text.trim(),
    );

    final state = ref.read(idiomControllerProvider);

    if (!state.hasError && mounted) {
      context.go('/admin/manage-idioms');
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.invalidate(idiomGroupListProvider);
    final state = ref.watch(idiomControllerProvider);

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
          title: const Text('Add Idioms Group'),
          backgroundColor: Colors.transparent,
        ),
        body: ResponsiveWrapper(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const SizedBox(height: 16),
                  TextFormField(
                    style: const TextStyle(color: Color(0xFFD8E2E4)),
                    controller: _groupNameController,
                    decoration: const InputDecoration(labelText: 'Group Name'),
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  for (int i = 0; i < 3; i++) ...[
                    Text('Idiom ${i + 1}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextFormField(
                      cursorColor: Color(0xFFD8E2E4),
                      style: const TextStyle(color: Color(0xFFD8E2E4)),
                      controller: _textControllers[i],
                      decoration: const InputDecoration(labelText: 'Idiom'),
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      style: const TextStyle(color: Color(0xFFD8E2E4)),
                      cursorColor: Color(0xFFD8E2E4),
                      controller: _meaningControllers[i],
                      decoration: const InputDecoration(labelText: 'Meaning'),
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      style: const TextStyle(color: Color(0xFFD8E2E4)),
                      cursorColor: Color(0xFFD8E2E4),
                      controller: _usageControllers[i],
                      decoration: const InputDecoration(labelText: 'Usage'),
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                  ],
                  ElevatedButton(
                    onPressed: state.isLoading ? null : _handleSubmit,
                    child: state.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Add Idioms'),
                  ),
                  if (state.hasError)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text('Error: ${state.error}',
                          style: const TextStyle(color: Colors.red)),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
