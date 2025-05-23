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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBAemXvRDojI-CtLB0wqI66zbOP1uaBJmI',
    appId: '1:261202671763:web:d756be6745a878d3b7f566',
    messagingSenderId: '261202671763',
    projectId: 'puzzle-scout-cd872',
    authDomain: 'puzzle-scout-cd872.firebaseapp.com',
    storageBucket: 'puzzle-scout-cd872.firebasestorage.app',
    measurementId: 'G-93DP44MFG6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDFN_YlSqQLfi2SMKbfQ8Bt4PLei6qjq6M',
    appId: '1:261202671763:android:81fdb30a25035b70b7f566',
    messagingSenderId: '261202671763',
    projectId: 'puzzle-scout-cd872',
    storageBucket: 'puzzle-scout-cd872.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDq7LVN3_dfE41OAPXEOKIwPubk67d_5kw',
    appId: '1:261202671763:ios:006132523c87b286b7f566',
    messagingSenderId: '261202671763',
    projectId: 'puzzle-scout-cd872',
    storageBucket: 'puzzle-scout-cd872.firebasestorage.app',
    iosBundleId: 'com.borgatrust.borgatrust',
  );
}
