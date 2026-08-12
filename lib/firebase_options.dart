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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // Web configuration registered in Firebase Console.
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyB6CvDR8qVLeUHsOFJ-kZUfl5LKtjARUGQ",
    authDomain: "slanh-pets-app.firebaseapp.com",
    projectId: "slanh-pets-app",
    storageBucket: "slanh-pets-app.firebasestorage.app",
    messagingSenderId: "899562761334",
    appId: "1:899562761334:web:b260d661a95e2af701c357",
    measurementId: "G-EJ0M424SG2",
  );

  // Android configuration from android/app/google-services.json.
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA5dLcaxwIZ9dJ1Y-y2jGtffyKxyWGd4zs',
    appId: '1:899562761334:android:b8adcf2cc394ce3501c357',
    messagingSenderId: '899562761334',
    projectId: 'slanh-pets-app',
    storageBucket: 'slanh-pets-app.firebasestorage.app',
  );
}
