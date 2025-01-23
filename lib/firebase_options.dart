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
    apiKey: 'KEY',
    appId: 'ID',
    messagingSenderId: 'MESSAGE_ID',
    projectId: 'PROJECT_ID',
    authDomain: 'DOMAIN',
    storageBucket: 'STORAGE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'KEY',
    appId: 'ID',
    messagingSenderId: 'MESSAGE_ID',
    projectId: 'PROJECT_ID',
    storageBucket: 'STORAGE',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'KEY',
    appId: 'ID',
    messagingSenderId: 'MESSAGE_ID',
    projectId: 'PROJECT_ID',
    storageBucket: 'STORAGE',
    iosBundleId: 'com.example.flutterChat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'KEY',
    appId: 'ID',
    messagingSenderId: 'MESSAGE_ID',
    projectId: 'PROJECT_ID',
    storageBucket: 'STORAGE',
    iosBundleId: 'com.example.flutterChat',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'KEY',
    appId: 'ID',
    messagingSenderId: 'MESSAGE_ID',
    projectId: 'PROJECT_ID',
    authDomain: 'DOMAIN',
    storageBucket: 'STORAGE',
  );

}