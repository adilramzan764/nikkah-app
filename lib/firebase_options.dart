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
    apiKey: "AIzaSyCVnrVvsYvP9bdWHSuERxTZcuzsM6v0POI",
    authDomain: "nikkah-app-b0234.firebaseapp.com",
    databaseURL: "https://nikkah-app-b0234-default-rtdb.firebaseio.com",
    projectId: "nikkah-app-b0234",
    storageBucket: "nikkah-app-b0234.appspot.com",
    messagingSenderId: "994774960958",
    appId: "1:994774960958:web:c36694b4c84f1b059fba6f",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBhJBf9hEUQrGDYWr8IQFLk2jLpfz2eVJg',
    appId: '1:994774960958:android:307b2a523e48841d9fba6f',
    messagingSenderId: '994774960958',
    projectId: 'nikkah-app-b0234',
    storageBucket: 'nikkah-app-b0234.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBqJmt2L88TMfT2zyd0p82LlOk4yXWfyi0',
    appId: '1:994774960958:ios:a6d6d525ca3a74a29fba6f',
    messagingSenderId: '994774960958',
    projectId: 'nikkah-app-b0234',
    storageBucket: 'nikkah-app-b0234.appspot.com',
    androidClientId: '994774960958-502fse427bgg68ttu041trnkl5n0b73b.apps.googleusercontent.com',
    iosClientId: '994774960958-uja6s1di0dsf7ptfp23a740me53kj4ip.apps.googleusercontent.com',
    iosBundleId: 'com.example.nikkahApp',
  );
}
