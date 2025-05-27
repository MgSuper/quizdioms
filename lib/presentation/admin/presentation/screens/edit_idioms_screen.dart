import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/data/models/idioms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/presentation/providers/idiom_list_provider.dart';
import 'package:quizdioms/presentation/user/navigation/responsive_wrapper.dart';

class EditIdiomsScreen extends ConsumerStatefulWidget {
  final IdiomGroup group;

  const EditIdiomsScreen({super.key, required this.group});

  @override
  ConsumerState<EditIdiomsScreen> createState() => _EditIdiomsScreenState();
}

class _EditIdiomsScreenState extends ConsumerState<EditIdiomsScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _groupNameController;
  late final List<TextEditingController> _textControllers;
  late final List<TextEditingController> _meaningControllers;
  late final List<TextEditingController> _usageControllers;

  bool _isLoading = false;

  @override
  void initState() {
    final idioms = widget.group.idioms;

    _groupNameController = TextEditingController(text: widget.group.groupName);
    _textControllers =
        idioms.map((e) => TextEditingController(text: e.text)).toList();
    _meaningControllers =
        idioms.map((e) => TextEditingController(text: e.meaning)).toList();
    _usageControllers =
        idioms.map((e) => TextEditingController(text: e.usage)).toList();

    super.initState();
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    for (final c in [
      ..._textControllers,
      ..._meaningControllers,
      ..._usageControllers
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final idioms = List.generate(3, (i) {
      return Idiom(
        text: _textControllers[i].text.trim(),
        meaning: _meaningControllers[i].text.trim(),
        usage: _usageControllers[i].text.trim(),
      );
    });

    final updatedData = {
      'groupName': _groupNameController.text.trim(),
      'idioms': idioms.map((e) => e.toJson()).toList(),
    };

    await FirebaseFirestore.instance
        .collection('idioms')
        .doc(widget.group.id)
        .update(updatedData);

    ref.invalidate(idiomGroupListProvider);

    if (mounted) {
      setState(() => _isLoading = false);
      context.go('/admin/manage-idioms');
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
          title: const Text('Edit Idioms Group'),
        ),
        body: ResponsiveWrapper(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const SizedBox(height: 8),
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
                      style: const TextStyle(color: Color(0xFFD8E2E4)),
                      cursorColor: Color(0xFFD8E2E4),
                      controller: _textControllers[i],
                      decoration: const InputDecoration(labelText: 'Text'),
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
                    onPressed: _isLoading ? null : _handleSubmit,
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Update Idioms'),
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
