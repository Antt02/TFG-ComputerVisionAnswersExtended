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

  //List of actions TODO: Correct all actions
  List actions = [
    //ActionName, Image, Redirect
    ["SmartPlant", "../images/800px-Circle_-_black_simple.svg.png", LoginPage()],
    ["ChatAssistant", "../images/800px-Circle_-_black_simple.svg.png", LoginPage()],
    ["AutoMate", "../images/800px-Circle_-_black_simple.svg.png", LoginPage()],
  ];


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
      body: SafeArea(
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
                  Text('UserName ',
                      style: GoogleFonts.bebasNeue(
                          color: AppColors.darkGreen,
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                ],
              ),

              //List of actions

              Expanded(
                child: GridView.builder(
                  itemCount: actions.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                  itemBuilder: (context, index){
                      return ActionsBox(
                        actionName: actions[index][0],
                        iconRoute: actions[index][1],
                        redirectScreen: actions[index][2],
                      );
                  },
                ),
              ),
            ],
          ),
        ),
      );
  }
}
