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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyArRWlbHEow84mLw9b7oYoQwnL_D_zIZUE',
    appId: '1:342743226451:android:1d7eb5d1dc0246d7378ea6',
    messagingSenderId: '342743226451',
    projectId: 'glot-c5df4',
    databaseURL: 'https://glot-c5df4-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'glot-c5df4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAcIftuH9L4wJ8NM4AlC7NIIpdGOIO7E2s',
    appId: '1:342743226451:ios:765a97c1cff94de9378ea6',
    messagingSenderId: '342743226451',
    projectId: 'glot-c5df4',
    databaseURL: 'https://glot-c5df4-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'glot-c5df4.appspot.com',
    iosClientId: '342743226451-5islm0mcd43m7ibae65cttfeppm1ngu8.apps.googleusercontent.com',
    iosBundleId: 'com.example.poliglot',
  );
}
