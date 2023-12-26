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
    apiKey: 'AIzaSyCQJTZ2CyfSJuErJg5ljoS_5nyIrk7DZdk',
    appId: '1:506092231511:web:8c34af7928ecd159537c12',
    messagingSenderId: '506092231511',
    projectId: 'mobilni-zpevnik',
    authDomain: 'mobilni-zpevnik.firebaseapp.com',
    storageBucket: 'mobilni-zpevnik.appspot.com',
    measurementId: 'G-269MTPR927',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDd5y3ukckksqFQDwwf4PvEM43Bx2AVSkI',
    appId: '1:506092231511:android:3f422bdf37ce22b0537c12',
    messagingSenderId: '506092231511',
    projectId: 'mobilni-zpevnik',
    storageBucket: 'mobilni-zpevnik.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCOAYkbQsG5G9ycUODscdMt3-HK3yVu0YI',
    appId: '1:506092231511:ios:db69b9fb5f0dc4b3537c12',
    messagingSenderId: '506092231511',
    projectId: 'mobilni-zpevnik',
    storageBucket: 'mobilni-zpevnik.appspot.com',
    iosBundleId: 'com.example.mobilniZpevnik',
  );
}