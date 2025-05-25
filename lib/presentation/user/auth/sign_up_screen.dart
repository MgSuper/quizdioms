import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quizdioms/presentation/providers/auth_provider.dart';
import 'package:quizdioms/presentation/user/auth/widgets/auth_form_widget.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return AuthFormWidget(
      title: 'Create an Account',
      buttonLabel: 'Sign Up',
      isLoading: authState.isLoading,
      onSubmit: (email, password) {
        ref
            .read(authControllerProvider.notifier)
            .signUp(context, email, password);
      },
      bottomText: "Already have an account?",
      onToggle: () => context.go('/signin'),
    );
  }
}
