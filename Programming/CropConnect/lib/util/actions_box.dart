import 'package:crop_connect/home_page.dart';
import 'package:crop_connect/login_page.dart';
import 'package:crop_connect/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionsBox extends StatelessWidget {
  final String actionName;
  final String iconRoute;
  final redirectScreen;

  const ActionsBox({super.key,
    required this.actionName,
    required this.iconRoute,
    required this.redirectScreen
  });



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => redirectScreen));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Container(
          height: 250,
          width: 1200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft,
              stops: const [0.4, 0.6],
              colors: [AppColors.darkGreen2, AppColors.baseGreen],
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icono
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Image.asset(
                  iconRoute,
                  height: 120,
                ),
              ),
              // Nombre
              Expanded(
                child: Center(
                  child: Text(
                    actionName,
                    style: GoogleFonts.bebasNeue(
                      color: AppColors.bone,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Flecha
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: Icon(Icons.arrow_forward_ios, size: 75, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
