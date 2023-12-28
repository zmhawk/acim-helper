// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

// 此秘钥可公开
// https://firebase.google.com/docs/projects/api-keys?hl=zh&authuser=0

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA6EvH7IwyOHdvUt8fgOeDjkMM-OoPf6AE',
    appId: '1:677316897065:web:d9c16acbbe1a8a2a03ef38',
    messagingSenderId: '677316897065',
    projectId: 'acim-helper',
    authDomain: 'acim-helper.firebaseapp.com',
    storageBucket: 'acim-helper.appspot.com',
    measurementId: 'G-806WJE9YJC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCApe1fVxGYM01Ak84qeNekPB37jqBfjmY',
    appId: '1:677316897065:android:b5db6647263fc5cb03ef38',
    messagingSenderId: '677316897065',
    projectId: 'acim-helper',
    storageBucket: 'acim-helper.appspot.com',
  );
}
