import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizdioms/presentation/providers/theme_mode_provider.dart';
import 'package:quizdioms/presentation/user/navigation/responsive_wrapper.dart';
import 'package:quizdioms/presentation/user/screens/profile/providers/user_progress_provider.dart';
import 'package:quizdioms/presentation/providers/auth_provider.dart';
import 'package:quizdioms/presentation/user/widgets/user_app_bar.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).asData?.value;
    final progress = ref.watch(userProgressProvider);

    final themeModeAsync = ref.watch(themeModeProvider);
    final themeNotifier = ref.read(themeModeProvider.notifier);

// Default to system if still loading
    final themeMode = themeModeAsync.value ?? ThemeMode.system;
    final isDark = themeMode == ThemeMode.dark;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('User not signed in')),
      );
    }

    final avatarLetter = user.email?.substring(0, 1).toUpperCase() ?? '?';
    final isWeb = MediaQuery.of(context).size.width >= 640;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const UserAppBar(title: 'Profile'),
      body: ResponsiveWrapper(
        child: SingleChildScrollView(
          padding: isWeb ? EdgeInsets.zero : const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar & Email
              Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    child: Text(avatarLetter,
                        style: const TextStyle(fontSize: 24)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.email ?? '',
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 4),
                        Text(user.uid,
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),

              // Progress section
              const Text('Progress',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              progress.when(
                data: (data) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Idioms learned: ${data.idiomsLearned}'),
                    Text('Phrases learned: ${data.phrasesLearned}'),
                    Text('Quizzes completed: ${data.quizzesCompleted}'),
                    Text('Avg score: ${data.avgScore ?? "--"}%'),
                  ],
                ),
                loading: () => Shimmer.fromColors(
                  baseColor: Colors.grey.shade400,
                  highlightColor: Colors.grey.shade200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(4, (_) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 12,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                ),
                error: (e, _) => Text('Error: $e'),
              ),

              const SizedBox(height: 32),

              // Settings
              const Text('Settings',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              if (themeModeAsync.isLoading)
                const CircularProgressIndicator()
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Dark Mode'),
                    Switch(
                      value: isDark,
                      onChanged: (value) => themeNotifier.toggle(),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
