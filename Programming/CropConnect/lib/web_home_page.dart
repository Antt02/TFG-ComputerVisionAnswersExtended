import 'package:crop_connect/login_page.dart';
import 'package:crop_connect/my_colors.dart';
import 'package:crop_connect/util/actions_box.dart';
import 'package:crop_connect/util/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WebHomePage extends StatefulWidget {
  const WebHomePage({Key? key}) : super(key: key);

  @override
  State<WebHomePage> createState() => _WebHomePageState();
}

class _WebHomePageState extends State<WebHomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  double separation = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome ',
                      style: GoogleFonts.bebasNeue(
                          color: AppColors.darkGreen,
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                  Text("${user.displayName} !",
                      style: GoogleFonts.bebasNeue(
                          color: AppColors.darkGreen,
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 25),
              // List of actions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                     ActionsBox(
                      actionName: "What To Plant",
                      description: "Use AI to know what's best for you",
                      gradientStartColor: AppColors.darkGreen2,
                      gradientEndColor: AppColors.darkGreen,
                      iconRoute: "images/what_to_plant.png",
                      redirectScreen: AppLoginPage(),
                    ),
                    SizedBox(height: separation),
                     ActionsBox(
                      actionName: "SmartPlant",
                      description: "Use AI to know what's best for you",
                       gradientStartColor: AppColors.darkGreen2,
                       gradientEndColor: AppColors.darkGreen,
                      iconRoute: "images/800px-Circle_-_black_simple.svg.png",
                      redirectScreen: AppLoginPage(),
                    ),
                    SizedBox(height: separation),
                     ActionsBox(
                      actionName: "SmartPlant",
                      description: "Use AI to know what's best for you",
                       gradientStartColor: AppColors.darkGreen2,
                       gradientEndColor: AppColors.darkGreen,
                      iconRoute: "images/800px-Circle_-_black_simple.svg.png",
                      redirectScreen: AppLoginPage(),
                    ),
                    SizedBox(height: separation),
                     ActionsBox(
                      actionName: "SmartPlant",
                      description: "Use AI to know what's best for you",
                       gradientStartColor: AppColors.darkGreen2,
                       gradientEndColor: AppColors.darkGreen,
                      iconRoute: "images/800px-Circle_-_black_simple.svg.png",
                      redirectScreen: AppLoginPage(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
