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
    apiKey: 'AIzaSyCBJuZlVkkwtii5HMSOUukeN-kestsQrPg',
    appId: '1:350210470452:web:96b51e1836ed761a2f1061',
    messagingSenderId: '350210470452',
    projectId: 'assignment-2-c9266',
    authDomain: 'assignment-2-c9266.firebaseapp.com',
    storageBucket: 'assignment-2-c9266.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCUVqqcfY3jXUIpGyk3jJ38XJ0BR2qcklM',
    appId: '1:350210470452:android:503633fa7b0870a02f1061',
    messagingSenderId: '350210470452',
    projectId: 'assignment-2-c9266',
    storageBucket: 'assignment-2-c9266.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCo3i9yN2vi3u0F7pAiMAvK3AJdZpl094Q',
    appId: '1:350210470452:ios:57130a69c9c68a1e2f1061',
    messagingSenderId: '350210470452',
    projectId: 'assignment-2-c9266',
    storageBucket: 'assignment-2-c9266.appspot.com',
    iosClientId: '350210470452-aqvh7e2goj8gmvpvr20pkmkt942knro7.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterAssigment2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCo3i9yN2vi3u0F7pAiMAvK3AJdZpl094Q',
    appId: '1:350210470452:ios:57130a69c9c68a1e2f1061',
    messagingSenderId: '350210470452',
    projectId: 'assignment-2-c9266',
    storageBucket: 'assignment-2-c9266.appspot.com',
    iosClientId: '350210470452-aqvh7e2goj8gmvpvr20pkmkt942knro7.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterAssigment2',
  );
}
