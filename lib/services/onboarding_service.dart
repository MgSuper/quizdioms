import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingService {
  static const _key = 'onboardingCompleted';

  Future<void> setCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, true);
  }

  Future<bool> isCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }
}
