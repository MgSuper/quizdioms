import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizdioms/domain/repositories/auth_repository.dart';
import 'package:quizdioms/data/repositories_impl/auth_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(FirebaseAuth.instance, FirebaseFirestore.instance);
}

@riverpod
Stream<User?> authState(Ref ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
}

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<void> signIn(
      BuildContext context, String email, String password) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(
        () => ref.read(authRepositoryProvider).signIn(email, password));

    if (result.hasError) {
      if (!context.mounted) return;
      _showError(context, result.error);
    }

    state = result;
  }

  Future<void> signUp(
      BuildContext context, String email, String password) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(
        () => ref.read(authRepositoryProvider).signUp(email, password));

    if (result.hasError) {
      if (!context.mounted) return;
      _showError(context, result.error);
    }

    state = result;
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
  }

  void _showError(BuildContext context, Object? error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error.toString()),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
