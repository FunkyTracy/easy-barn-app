// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyBry0eAORX-kzeFHZWZmW1lQo87Q9NmvDg',
    appId: '1:364937274171:web:d0ccec549987dace66cd1e',
    messagingSenderId: '364937274171',
    projectId: 'easybarn-21756',
    authDomain: 'easybarn-21756.firebaseapp.com',
    storageBucket: 'easybarn-21756.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBVXqoBjgMClmePTzYlaMoWE16Ajt3Q0cg',
    appId: '1:364937274171:android:10e158ee9f8e7c3666cd1e',
    messagingSenderId: '364937274171',
    projectId: 'easybarn-21756',
    storageBucket: 'easybarn-21756.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCOCUW7GjeBNgfqz6r15jEqIilqT76sbHc',
    appId: '1:364937274171:ios:7d8e57fb400f940b66cd1e',
    messagingSenderId: '364937274171',
    projectId: 'easybarn-21756',
    storageBucket: 'easybarn-21756.appspot.com',
    iosBundleId: 'com.example.easyBarn',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCOCUW7GjeBNgfqz6r15jEqIilqT76sbHc',
    appId: '1:364937274171:ios:426ed9622d9edb7466cd1e',
    messagingSenderId: '364937274171',
    projectId: 'easybarn-21756',
    storageBucket: 'easybarn-21756.appspot.com',
    iosBundleId: 'com.example.easyBarn.RunnerTests',
  );
}