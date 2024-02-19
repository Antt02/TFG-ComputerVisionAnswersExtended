import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'my_colors.dart';

class AppLoginPage extends StatefulWidget {
  const AppLoginPage({Key? key}) : super(key: key);

  @override
  State<AppLoginPage> createState() => _AppLoginPageState();
}

class _AppLoginPageState extends State<AppLoginPage> {
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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // AppName
                const Text(
                  'Welcome to\nCropConnect!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "SanFrancisco",
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -2,
                  ),
                ),
                SvgPicture.asset(
                  "./images/logo.svg",
                  semanticsLabel: "CropConnect Logo",
                  height: 123,
                  width: 123,
                ),
                const SizedBox(height: 30),

                // email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                      fillColor: Colors.grey[100],
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signIn,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: const [0.4, 0.6],
                          colors: [
                            AppColors.darkGreen2,
                            AppColors.baseGreen,
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontFamily: "SanFrancisco",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
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
                    Text(
                      "Not a Member? ",
                      style: TextStyle(
                        color: AppColors.darkGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // TODO: change to create a redirect to mail
                      },
                      child: Text(
                        "Contact Us",
                        style: TextStyle(
                          color: AppColors.darkGreen2,
                          fontWeight: FontWeight.bold,
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
    );
  }
}
