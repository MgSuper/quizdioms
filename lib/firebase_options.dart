// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDyD2FNvU8UwWYE90dlBoJDld8HDYdD_aU',
    appId: '1:341565679686:web:f37adca4b6d8329c64c247',
    messagingSenderId: '341565679686',
    projectId: 'quizdioms',
    authDomain: 'quizdioms.firebaseapp.com',
    storageBucket: 'quizdioms.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA_yMWDA3O-2oQ_paGDhITKqN6v_CjKODo',
    appId: '1:341565679686:android:b7bb82c741382f0b64c247',
    messagingSenderId: '341565679686',
    projectId: 'quizdioms',
    storageBucket: 'quizdioms.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCEx7V94gCP5bDXXq2YAAVBU3queBA6MiM',
    appId: '1:341565679686:ios:b93c687b3edc1fc664c247',
    messagingSenderId: '341565679686',
    projectId: 'quizdioms',
    storageBucket: 'quizdioms.firebasestorage.app',
    iosBundleId: 'com.io.quizdioms.quizdioms',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCEx7V94gCP5bDXXq2YAAVBU3queBA6MiM',
    appId: '1:341565679686:ios:b93c687b3edc1fc664c247',
    messagingSenderId: '341565679686',
    projectId: 'quizdioms',
    storageBucket: 'quizdioms.firebasestorage.app',
    iosBundleId: 'com.io.quizdioms.quizdioms',
  );
}
