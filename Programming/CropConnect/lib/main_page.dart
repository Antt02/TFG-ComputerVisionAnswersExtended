import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:crop_connect/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'app_home_page.dart';
import 'web_home_page.dart';

class MainPage extends StatelessWidget{
  const MainPage ({Key ? key}) : super (key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          if (kIsWeb) {
            print("Running on web");
            return const WebHomePage();
          } else {
            //Running on App
            print("Running on App");
            return const AppHomePage();
          }
        }else{
          return const LoginPage();
        }
      },
      ),
    );
  }
}