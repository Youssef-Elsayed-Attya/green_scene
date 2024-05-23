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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBtdPSM_x_IqLGQ-vyV516huotmb4dJ8Us',
    appId: '1:318656920288:android:965707d110600d5bb92e85',
    messagingSenderId: '318656920288',
    projectId: 'iot-smart-agriculture-91d92',
    databaseURL: 'https://iot-smart-agriculture-91d92-default-rtdb.firebaseio.com',
    storageBucket: 'iot-smart-agriculture-91d92.appspot.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCcwxBcT6eY2a2DMaRGhj37fpX1x5JOseE',
    appId: '1:318656920288:web:8062e3216b94c979b92e85',
    messagingSenderId: '318656920288',
    projectId: 'iot-smart-agriculture-91d92',
    authDomain: 'iot-smart-agriculture-91d92.firebaseapp.com',
    databaseURL: 'https://iot-smart-agriculture-91d92-default-rtdb.firebaseio.com',
    storageBucket: 'iot-smart-agriculture-91d92.appspot.com',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCcwxBcT6eY2a2DMaRGhj37fpX1x5JOseE',
    appId: '1:318656920288:web:b6018c61290facbcb92e85',
    messagingSenderId: '318656920288',
    projectId: 'iot-smart-agriculture-91d92',
    authDomain: 'iot-smart-agriculture-91d92.firebaseapp.com',
    databaseURL: 'https://iot-smart-agriculture-91d92-default-rtdb.firebaseio.com',
    storageBucket: 'iot-smart-agriculture-91d92.appspot.com',
  );

}