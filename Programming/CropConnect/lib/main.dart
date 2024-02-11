
// ignore_for_file: prefer_const_constructors

import 'dart:io' show Platform;
import 'package:crop_connect/main_page.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCMOBNs1Dbhs_JypZNFKC1AVht1Sb88smo",
          appId: "1:83065108693:android:df7cbe55c7574ddd4c8a5c",
          messagingSenderId: "83065108693",
          projectId: "cropconnect-85a98"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}