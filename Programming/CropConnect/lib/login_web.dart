import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'my_colors.dart';

class WebLoginPage extends StatefulWidget {
  const WebLoginPage({Key? key}) : super(key: key);

  @override
  State<WebLoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<WebLoginPage> {
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final passwordErrorMessage = const SnackBar(
    content: Text('Invalid Mail or Password'),
    backgroundColor: Colors.redAccent,
  );

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on Exception catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(passwordErrorMessage);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Imagen que ocupa toda la pantalla
            Positioned.fill(
              child: Image.asset(
                "images/campo.jpg",
                fit: BoxFit.cover,
              ),
            ),

            // Formulario de inicio de sesión superpuesto en la parte derecha
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.only(right: 45, top: 40, bottom: 40),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomRight,
                      stops: [0.12, 1],
                      colors: [
                        Colors.white,
                        Colors.white70,
                      ],
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.25,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // AppName y logo
                      const Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: Text(
                          'Welcome to CropConnect!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "SanFrancisco",
                            color: Colors.black,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: SvgPicture.asset(
                          "./images/logo.svg",
                          semanticsLabel: "CropConnect Logo",
                          height: 150,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Email textfield
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.darkGreen),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: AutofillHints.email,
                            hintStyle: const TextStyle(
                              fontFamily: "SanFranciso",
                            ),
                            fillColor: Colors.grey[100],
                            filled: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Password textfield
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          obscureText: true,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.darkGreen),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: AutofillHints.password,
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // SignIn button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: GestureDetector(
                          onTap: signIn,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                stops: const [0.4, 0.6],
                                colors: [
                                  AppColors.darkGreen2,
                                  AppColors.darkGreen,
                                ],
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 20),
                              child: Center(
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontFamily: "SanFrancisco",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Register button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Not a Member? ",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // TODO: change to create a redirect to mail
                            },
                            child: const Text(
                              "Contact Us",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
