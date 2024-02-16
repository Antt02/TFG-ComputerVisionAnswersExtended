import 'package:crop_connect/home_page.dart';
import 'package:crop_connect/login_page.dart';
import 'package:crop_connect/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionsBox extends StatelessWidget {
  final String actionName;
  final String iconRoute;
  final String description;
  final redirectScreen;

  const ActionsBox({super.key,
    required this.actionName,
    required this.description,
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
            boxShadow: [
              BoxShadow(
                color: AppColors.darkGreen2.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icono
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    iconRoute,
                    height: 80,
                  ),
                ),
              ),
              // Espaciador
              SizedBox(width: 20),
              // Columna para Título y Descripción
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Título
                    Text(
                      actionName,
                      style: TextStyle(
                        color: AppColors.bone,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        fontFamily: 'Roboto', // Cambia la fuente según tu preferencia
                        shadows: [
                          Shadow(
                            color: AppColors.darkGreen2.withOpacity(0.7),
                            blurRadius: 2,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                    // Descripción
                    Text(
                      description,
                      style: TextStyle(
                        color: AppColors.bone,
                        fontSize: 16,
                        fontFamily: 'Roboto', // Cambia la fuente según tu preferencia
                      ),
                    ),
                  ],
                ),
              ),
              // Flecha
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: Icon(Icons.arrow_forward_ios, size: 40, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
