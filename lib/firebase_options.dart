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
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAEgGQ8XKWOI9rWtz7IdrN6W3JHz0PefS0',
    appId: '1:803408501170:web:16def26d53b15336d56cab',
    messagingSenderId: '803408501170',
    projectId: 'cloud-messaging-c1e2d',
    authDomain: 'cloud-messaging-c1e2d.firebaseapp.com',
    storageBucket: 'cloud-messaging-c1e2d.firebasestorage.app',
    measurementId: 'G-ENJF6W70YJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC6JReMt9U0CpZEVS5HVUVKCECF74pISlc',
    appId: '1:803408501170:android:34fb5baec9deab79d56cab',
    messagingSenderId: '803408501170',
    projectId: 'cloud-messaging-c1e2d',
    storageBucket: 'cloud-messaging-c1e2d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAUccdXfv3pvTTiI6coywcA_YwQSM9itxk',
    appId: '1:803408501170:ios:86f625b0ba2e5f52d56cab',
    messagingSenderId: '803408501170',
    projectId: 'cloud-messaging-c1e2d',
    storageBucket: 'cloud-messaging-c1e2d.firebasestorage.app',
    iosBundleId: 'com.example.cloudmessaging',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAUccdXfv3pvTTiI6coywcA_YwQSM9itxk',
    appId: '1:803408501170:ios:86f625b0ba2e5f52d56cab',
    messagingSenderId: '803408501170',
    projectId: 'cloud-messaging-c1e2d',
    storageBucket: 'cloud-messaging-c1e2d.firebasestorage.app',
    iosBundleId: 'com.example.cloudmessaging',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAEgGQ8XKWOI9rWtz7IdrN6W3JHz0PefS0',
    appId: '1:803408501170:web:807dda069ec04050d56cab',
    messagingSenderId: '803408501170',
    projectId: 'cloud-messaging-c1e2d',
    authDomain: 'cloud-messaging-c1e2d.firebaseapp.com',
    storageBucket: 'cloud-messaging-c1e2d.firebasestorage.app',
    measurementId: 'G-WYW5NTDX3J',
  );
}
