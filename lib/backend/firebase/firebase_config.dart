import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyB639Eq6UOzLQPdC59sAZE6tYG-ic7rVlU",
            authDomain: "spasht-25f2c.firebaseapp.com",
            projectId: "spasht-25f2c",
            storageBucket: "spasht-25f2c.firebasestorage.app",
            messagingSenderId: "1060642327154",
            appId: "1:1060642327154:web:b6ba1ca19f3aebe19150eb",
            measurementId: "G-0MG661H18V"));
  } else {
    await Firebase.initializeApp();
  }
}
