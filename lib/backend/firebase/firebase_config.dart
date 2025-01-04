import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyA1FcZJ-JURrtALQz3PJNG6-_lSFfrjdUU",
            authDomain: "esen-meal-ehwrlb.firebaseapp.com",
            projectId: "esen-meal-ehwrlb",
            storageBucket: "esen-meal-ehwrlb.firebasestorage.app",
            messagingSenderId: "594042224286",
            appId: "1:594042224286:web:27bda2241f65ff2543458f"));
  } else {
    await Firebase.initializeApp();
  }
}
