import 'package:flutter/material.dart';

import '../my_colors.dart';

class ActionsBox extends StatefulWidget {
  final String actionName;
  final String iconRoute;
  final String description;
  final redirectScreen;

  const ActionsBox({
    super.key,
    required this.actionName,
    required this.description,
    required this.iconRoute,
    required this.redirectScreen,
  });

  @override
  _ActionsBoxState createState() => _ActionsBoxState();
}

class _ActionsBoxState extends State<ActionsBox> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: MouseRegion(
        onEnter: (_) => _handleHover(true),
        onExit: (_) => _handleHover(false),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => widget.redirectScreen),
            );
          },
          child: Container(
            height: isHovered ? 320 : 280,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomLeft,
                stops: const [0.3, 0.8],
                colors: [
                  AppColors.darkGreen2,
                  isHovered ? AppColors.paleGreen.withOpacity(0.3) : AppColors.baseGreen,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.darkGreen2.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icono
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.darkGreen2.withOpacity(0.7),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Image.asset(
                    widget.iconRoute,
                    height: 100,
                  ),
                ),
                // Espaciador
                const SizedBox(height: 20),
                // Columna para Título y Descripción
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Título
                    Text(
                      widget.actionName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    // Descripción
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        widget.description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.bone.withOpacity(0.8),
                          fontSize: 16,
                          fontFamily: 'Montserrat',
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

  void _handleHover(bool hover) {
    setState(() {
      isHovered = hover;
    });
  }
}
