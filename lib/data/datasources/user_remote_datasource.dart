import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRemoteDatasource {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> markOnboardingComplete() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      await docRef.update({'onboardingCompleted': true});
    } else {
      await docRef.set({'onboardingCompleted': true});
    }
  }

  Future<bool> isOnboardingCompleteRemote() async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      final doc = await _firestore.collection('users').doc(uid).get();
      return doc.data()?['onboardingCompleted'] ?? false;
    }
    return false;
  }
}
