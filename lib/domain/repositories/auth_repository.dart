import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<void> signIn(String email, String password);
  Future<void> signUp(String email, String password);
  Future<void> signOut();
  Stream<User?> authStateChanges();
}
