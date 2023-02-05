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
    apiKey: 'AIzaSyARqapCOD9W-vfXic0Hwx9ZqUG4PM6umnQ',
    appId: '1:787762285064:web:011ba8dfc8cfe07e6b1fbd',
    messagingSenderId: '787762285064',
    projectId: 'p2p-energy-trading-da7e6',
    authDomain: 'p2p-energy-trading-da7e6.firebaseapp.com',
    storageBucket: 'p2p-energy-trading-da7e6.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDWWN-tdsyOavWCe8l_GoXH5hgl1F0iOOU',
    appId: '1:787762285064:android:bfb52f9d451a0f5a6b1fbd',
    messagingSenderId: '787762285064',
    projectId: 'p2p-energy-trading-da7e6',
    storageBucket: 'p2p-energy-trading-da7e6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCIoSVxg_6jvn0Wl1DAuJk0Z3yZf2tT5TY',
    appId: '1:787762285064:ios:540ac9443613840c6b1fbd',
    messagingSenderId: '787762285064',
    projectId: 'p2p-energy-trading-da7e6',
    storageBucket: 'p2p-energy-trading-da7e6.appspot.com',
    iosClientId: '787762285064-9v7idm93m83uv3vjh4d4krlg4c783ps1.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCIoSVxg_6jvn0Wl1DAuJk0Z3yZf2tT5TY',
    appId: '1:787762285064:ios:540ac9443613840c6b1fbd',
    messagingSenderId: '787762285064',
    projectId: 'p2p-energy-trading-da7e6',
    storageBucket: 'p2p-energy-trading-da7e6.appspot.com',
    iosClientId: '787762285064-9v7idm93m83uv3vjh4d4krlg4c783ps1.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication',
  );
}
