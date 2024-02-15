// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'my_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final passwordErrorMessage = SnackBar(
    content: Text('Invalid Mail or Password'),
    backgroundColor: Colors.redAccent,
  );

  Future signIn() async{
    try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
    );
    }on Exception catch(_){
      ScaffoldMessenger.of(context).showSnackBar(passwordErrorMessage);
    }
  }

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bone,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(  
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //AppName
                Text('CropConnect',
                    style: GoogleFonts.bebasNeue(
                        color: AppColors.darkGreen,
                        fontSize: 60,
                        fontWeight: FontWeight.bold)),
                SvgPicture.asset(
                  "./images/logo.svg",
                  semanticsLabel: "CropConnect Logo",
                  height: 123,
                  width: 123,
                ),
                Text(
                  'Your connected crop',
                  style: GoogleFonts.montserrat(
                      color: AppColors.baseGreen,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50),

                //email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.darkGreen),
                        borderRadius: BorderRadius.circular(12)
                      ),
                      hintText: AutofillHints.email,
                      fillColor: Colors.grey[200],
                      filled: true
                      ),
                    ),
                  ),
                SizedBox(height: 8),

                //password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.darkGreen),
                            borderRadius: BorderRadius.circular(12)
                        ),

                        hintText: AutofillHints.password,
                        fillColor: Colors.grey[200],
                        filled: true
                    ),
                  ),
                ),
                SizedBox(height: 8),

                //SignIn button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signIn,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: const [
                            0.4,
                            0.6,
                          ],
                          colors: [
                            AppColors.darkGreen2,
                            AppColors.baseGreen
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                //Register button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a Member? ",
                      style: TextStyle(
                          color: AppColors.darkGreen,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap:  signIn, //TODO: change to create a redirect to mail
                      child: Text(
                        "Contact Us",
                        style: TextStyle(
                            color: AppColors.darkGreen2,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
