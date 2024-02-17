import 'package:flutter/material.dart';

import '../my_colors.dart';

class ActionsBox extends StatefulWidget {
  final String actionName;
  final String iconRoute;
  final String description;
  final redirectScreen;
  final gradientStartColor;
  final gradientEndColor;

  const ActionsBox({
    Key? key,
    required this.actionName,
    required this.description,
    required this.iconRoute,
    required this.redirectScreen,
    required this.gradientStartColor,
    required this.gradientEndColor,
  }) : super(key: key);

  @override
  _ActionsBoxState createState() => _ActionsBoxState();
}

class _ActionsBoxState extends State<ActionsBox> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
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
            height: isHovered ? 150 : 125,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomLeft,
                stops: [0.3, 0.8],
                colors: [
                  widget.gradientStartColor,
                  isHovered
                      ? widget.gradientEndColor.withOpacity(0.2)
                      : widget.gradientEndColor,
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
            child: Row(
              children: [
                // Icono
                Image.asset(
                  widget.iconRoute,
                  height: 100,
                ),
                // Contenedor de texto
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(23),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Titulo
                          Center(
                            child: Text(
                              widget.actionName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -1,
                                fontFamily: 'SanFrancisco',
                              ),
                            ),
                          ),

                          // Espaciador
                          const SizedBox(height: 10),

                          // Descripción
                          Center(
                            child: Text(
                              widget.description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.75),
                                letterSpacing: -0.5,
                                fontSize: 16,
                                fontFamily: 'SanFrancisco',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
