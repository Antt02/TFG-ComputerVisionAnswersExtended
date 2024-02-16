import 'package:crop_connect/login_page.dart';
import 'package:crop_connect/my_colors.dart';
import 'package:crop_connect/util/actions_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  double separation = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bone,
      appBar: AppBar(
        centerTitle: true,
        leading:IconButton(
            onPressed: () {
              print("Redirect to userpage"); //TODO: UserPage
            },
            icon: Icon(Icons.person)
        ),
        title: Text('CropConnect - Dashboard'),
        backgroundColor: AppColors.baseGreen,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),

        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Welcome ',
                        style: GoogleFonts.bebasNeue(
                            color: AppColors.darkGreen,
                            fontSize: 40,
                            fontWeight: FontWeight.bold)),
                    Text(user.displayName.toString(),
                        style: GoogleFonts.bebasNeue(
                            color: AppColors.darkGreen,
                            fontSize: 40,
                            fontWeight: FontWeight.bold)),
                  ],
                ),

                //List of actions
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                   child: Column(
                    children: [
                      const ActionsBox(
                        actionName: "What To Plant",
                        iconRoute: "../images/what_to_plant.png",
                        redirectScreen: LoginPage(),
                      ),
                      SizedBox(height: separation),
                      const ActionsBox(
                        actionName: "SmartPlant",
                        iconRoute: "../images/800px-Circle_-_black_simple.svg.png",
                        redirectScreen: LoginPage(),
                      ),
                      SizedBox(height: separation),
                      const ActionsBox(
                        actionName: "SmartPlant",
                        iconRoute: "../images/800px-Circle_-_black_simple.svg.png",
                        redirectScreen: LoginPage(),
                      ),
                      SizedBox(height: separation),
                      const ActionsBox(
                        actionName: "SmartPlant",
                        iconRoute: "../images/800px-Circle_-_black_simple.svg.png",
                        redirectScreen: LoginPage(),
                      )
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
