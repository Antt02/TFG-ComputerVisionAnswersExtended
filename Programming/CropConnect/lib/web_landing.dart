import 'package:crop_connect/util/web_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class WebLanding extends StatefulWidget {
  const WebLanding({Key? key}) : super(key: key);

  @override
  State<WebLanding> createState() => _WebHomePageState();
}

class _WebHomePageState extends State<WebLanding> {
  final user = FirebaseAuth.instance.currentUser!;

  double separation = 16.0;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WebAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        const Center(
                          child: Text('Welcome Back',
                            style: TextStyle(
                              fontFamily: "SanFrancisco",
                              color: Colors.black,
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -5,
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 65.0),

                            child: GradientText("${user?.displayName} !",
                                style: const TextStyle(
                                  fontFamily: "SanFrancisco",
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -5,
                                ),
                                gradientType: GradientType.linear,
                                colors: [Color(0xFF1AA161), Color(0xFF00351C)]
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 150),
                  const Text("Your Services. Take a look to your crop"),
                ],
              ),

              // List of actions
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 350,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  SizedBox(width: 50),
                  Container(
                    height: 350,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  SizedBox(width: 50),
                  Container(
                    height: 350,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  SizedBox(width: 50),
                  Container(
                    height: 350,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
