// data/repositories_impl/auth_repository_impl.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizdioms/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepositoryImpl(this._auth, this._firestore);

  @override
  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signUp(String email, String password) async {
    final userCred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await _firestore.collection('users').doc(userCred.user!.uid).set({
      'email': email,
      'role': 'user',
      'createdAt': FieldValue.serverTimestamp(),
      'onboardingCompleted': true,
    });
  }

  @override
  Future<void> signOut() async => _auth.signOut();

  @override
  Stream<User?> authStateChanges() => _auth.authStateChanges();
}
