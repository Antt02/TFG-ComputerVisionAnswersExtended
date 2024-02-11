
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ? await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCMOBNs1Dbhs_JypZNFKC1AVht1Sb88smo",
          appId: "1:83065108693:android:df7cbe55c7574ddd4c8a5c",
          messagingSenderId: "83065108693",
          projectId: "cropconnect-85a98"))
      : await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}