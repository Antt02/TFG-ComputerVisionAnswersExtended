// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'myColors.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bone,
      body:SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            //AppName
            Text('CropConnect',
            style: GoogleFonts.bebasNeue(
              color: AppColors.darkGreen,
              fontSize: 60,
              fontWeight: FontWeight.bold
            )),
              SvgPicture.asset("./images/logo.svg",
              semanticsLabel: "CropConnect Logo",
                height: 123,
                width: 123,
              ),
              Text('Your connected crop',
              style: GoogleFonts.montserrat(
                color: AppColors.baseGreen,
                fontSize: 20,
                fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 50),

            //email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left:15.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email"
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
            //password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left:15.0),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password"
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),

            //SignIn button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.baseGreen,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
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
                  Text("Not a Member? ", style: TextStyle(color: AppColors.darkGreen, fontWeight: FontWeight.bold),),
                  Text("Register Now", style: TextStyle(color: AppColors.darkGreen2, fontWeight: FontWeight.bold),)
                ],
              )
          ],),
        ),
      ),
    );
  }
}