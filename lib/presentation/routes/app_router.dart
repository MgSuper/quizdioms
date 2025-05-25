// lib/presentation/routes/app_router.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/data/models/idioms.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/domain/entities/quiz.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/presentation/screens/add_quiz_screen.dart';
import 'package:quizdioms/presentation/admin/manage_quizzes/presentation/screens/edit_quiz_screen.dart';
import 'package:quizdioms/presentation/admin/presentation/screens/add_idioms_screen.dart';
import 'package:quizdioms/presentation/admin/presentation/screens/admin_dashboard_screen.dart';
import 'package:quizdioms/presentation/admin/presentation/screens/admin_screen.dart';
import 'package:quizdioms/presentation/admin/presentation/screens/edit_idioms_screen.dart';
import 'package:quizdioms/presentation/admin/presentation/screens/manage_idioms_screen.dart';
import 'package:quizdioms/presentation/admin/presentation/screens/manage_quizzes_screen.dart';
import 'package:quizdioms/presentation/admin/presentation/screens/manage_quotes_screen.dart';
import 'package:quizdioms/presentation/admin/presentation/screens/user_list_screen.dart';
import 'package:quizdioms/presentation/home/presentation/screens/home_screen.dart';
import 'package:quizdioms/presentation/onboarding/landing_screen.dart';
import 'package:quizdioms/presentation/providers/auth_provider.dart';
import 'package:quizdioms/presentation/user/auth/sign_in_screen.dart';
import 'package:quizdioms/presentation/user/auth/sign_up_screen.dart';
import 'package:quizdioms/presentation/user/navigation/user_bottom_nav_scaffold.dart';
import 'package:quizdioms/presentation/user/screens/idioms/idiom_detail_screen.dart';
import 'package:quizdioms/presentation/user/screens/idioms/idiom_screen.dart';
import 'package:quizdioms/presentation/user/screens/performance_screen.dart';
import 'package:quizdioms/presentation/user/screens/phrase_screen.dart';
import 'package:quizdioms/presentation/user/screens/profile_screen.dart';
import 'package:quizdioms/presentation/user/screens/quizz/quiz_attempt_screen.dart';
import 'package:quizdioms/presentation/user/screens/quizz/quizz_result_screen.dart';
import 'package:quizdioms/presentation/user/screens/quizz/quizz_screen.dart';
import 'package:quizdioms/services/onboarding_service.dart';

class GoRouterAuthNotifier extends ChangeNotifier {
  GoRouterAuthNotifier(Ref ref) {
    ref.listen<AsyncValue<User?>>(
      authStateProvider,
      (previous, next) => notifyListeners(),
    );
  }
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final routerNotifier = GoRouterAuthNotifier(ref);
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
    refreshListenable: routerNotifier,
    observers: [MyNavigatorObserver()],
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const LandingScreen(),
      ),
      GoRoute(
        path: '/signin',
        builder: (_, __) => const SignInScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (_, __) => const SignUpScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => UserBottomNavScaffold(child: child),
        routes: [
          GoRoute(
            path: '/user/quizzes',
            builder: (_, __) => const QuizzScreen(),
          ),
          GoRoute(
            path: '/user/idioms',
            builder: (_, __) => const IdiomScreen(),
          ),
          GoRoute(
            path: '/user/idioms/detail',
            builder: (context, state) {
              final group = state.extra! as IdiomGroup;
              return IdiomDetailScreen(group: group); // you’ll build this next
            },
          ),
          GoRoute(
            path: '/user/phrases',
            builder: (_, __) => const PhraseScreen(),
          ),
          GoRoute(
            path: '/user/performance',
            builder: (_, __) => const PerformanceScreen(),
          ),
          GoRoute(
            path: '/user/profile',
            builder: (_, __) => const ProfileScreen(),
          ),
          GoRoute(
            path: '/user/quiz/attempt',
            builder: (context, state) {
              final quiz = state.extra as Quiz;
              return QuizAttemptScreen(quiz: quiz);
            },
          ),
          GoRoute(
            path: '/user/quiz/result',
            builder: (context, state) {
              final quiz = state.extra! as Quiz;
              final correctAnswers =
                  state.uri.queryParameters['correctAnswers'];
              final correctAnswersInt =
                  int.tryParse(correctAnswers ?? '0') ?? 0;
              return QuizResultScreen(
                  quiz: quiz, correctAnswers: correctAnswersInt);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/admin',
        builder: (_, __) => const AdminDashboardScreen(),
        routes: [
          GoRoute(
            path: 'manage-quizzes',
            builder: (_, __) => const ManageQuizzesScreen(),
            routes: [
              GoRoute(
                path: 'add-quiz',
                builder: (_, __) => const AddQuizScreen(),
              ),
              GoRoute(
                path: 'edit-quiz',
                builder: (context, state) {
                  final quiz = state.extra as Quiz;
                  return EditQuizScreen(quiz: quiz);
                },
              ),
            ],
          ),
          GoRoute(
            path: 'manage-idioms',
            builder: (_, __) => const ManageIdiomsScreen(),
            routes: [
              GoRoute(
                path: 'add-idiom',
                builder: (_, __) => const AddIdiomsScreen(), // 👈 new screen
              ),
              GoRoute(
                path: 'edit-idiom',
                builder: (context, state) {
                  final group = state.extra! as IdiomGroup;
                  return EditIdiomsScreen(group: group);
                },
              ),
            ],
          ),
          GoRoute(
            path: 'manage-quotes',
            builder: (_, __) => const ManageQuotesScreen(),
          ),
          GoRoute(
            path: 'user-performance',
            builder: (_, __) => const UserPerformanceScreen(),
          ),
        ],
      ),
    ],
    redirect: (context, state) async {
      final onboardingService = OnboardingService();
      final onboardingDone = await onboardingService.isCompleted();
      final auth = ref.read(authStateProvider);
      final user = auth.asData?.value;
      final isLoggingIn =
          state.uri.path == '/signin' || state.uri.path == '/signup';

      if (!onboardingDone) return '/';
      if (user == null) return isLoggingIn ? null : '/signin';

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final role = userDoc.data()?['role'] as String? ?? 'user';

      if (role == 'admin') {
        return state.uri.path.startsWith('/admin') ? null : '/admin';
      } else {
        return state.uri.path.startsWith('/user') ? null : '/user/quizzes';
      }
    },
  );
});

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {}

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {}

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {}

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {}
}
