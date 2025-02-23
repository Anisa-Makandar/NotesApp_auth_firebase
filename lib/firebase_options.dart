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
        return windows;
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
    apiKey: 'AIzaSyAN4e2YMpwn_rHMZrEwMXVvqR9H9t3ayS0',
    appId: '1:987715579915:web:1b7f6fe1b9184e5136170e',
    messagingSenderId: '987715579915',
    projectId: 'fir-withnoteapp',
    authDomain: 'fir-withnoteapp.firebaseapp.com',
    storageBucket: 'fir-withnoteapp.firebasestorage.app',
    measurementId: 'G-6ZN8GS9M2W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBLQ_KbAiTQ2sJ0l7rxFARehD7ins9g3w8',
    appId: '1:987715579915:android:626dfb40a236f3bc36170e',
    messagingSenderId: '987715579915',
    projectId: 'fir-withnoteapp',
    storageBucket: 'fir-withnoteapp.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBwW4ncGNH8m7C6nw-k58Ol36uNQnsqzW4',
    appId: '1:987715579915:ios:5956e56e19d742ee36170e',
    messagingSenderId: '987715579915',
    projectId: 'fir-withnoteapp',
    storageBucket: 'fir-withnoteapp.firebasestorage.app',
    iosBundleId: 'com.example.firebaseNoteapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBwW4ncGNH8m7C6nw-k58Ol36uNQnsqzW4',
    appId: '1:987715579915:ios:5956e56e19d742ee36170e',
    messagingSenderId: '987715579915',
    projectId: 'fir-withnoteapp',
    storageBucket: 'fir-withnoteapp.firebasestorage.app',
    iosBundleId: 'com.example.firebaseNoteapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAN4e2YMpwn_rHMZrEwMXVvqR9H9t3ayS0',
    appId: '1:987715579915:web:ce198eca0a89895e36170e',
    messagingSenderId: '987715579915',
    projectId: 'fir-withnoteapp',
    authDomain: 'fir-withnoteapp.firebaseapp.com',
    storageBucket: 'fir-withnoteapp.firebasestorage.app',
    measurementId: 'G-MPFW40YWRS',
  );
}
