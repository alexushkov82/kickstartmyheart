// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
      case TargetPlatform.fuchsia:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for fuchsia - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD4mN_XmrqU7uRX9qhOts_Qsixm6MG-iDc',
    appId: '1:801764179299:web:7bb2ba2839569fdbfa2756',
    messagingSenderId: '801764179299',
    projectId: 'kickstartmyheart',
    authDomain: 'kickstartmyheart.firebaseapp.com',
    storageBucket: 'kickstartmyheart.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyANe59S9C-N_9KA4Ds1DyMlG8h04KqUaEo',
    appId: '1:801764179299:android:4d0c3975c3ad47a6fa2756',
    messagingSenderId: '801764179299',
    projectId: 'kickstartmyheart',
    storageBucket: 'kickstartmyheart.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCK5U5FkrDgan4BKnEBC1EgujJDbQsPwSU',
    appId: '1:801764179299:ios:5eb3d5722333ee74fa2756',
    messagingSenderId: '801764179299',
    projectId: 'kickstartmyheart',
    storageBucket: 'kickstartmyheart.appspot.com',
    iosClientId: '801764179299-ia82b09vfi93ca0dldbhl9t9avq9aqsj.apps.googleusercontent.com',
    iosBundleId: 'COM.EXAMPLE.KICKSTARTMYHEART',
  );
}
