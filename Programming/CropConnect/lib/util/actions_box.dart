import 'package:crop_connect/home_page.dart';
import 'package:crop_connect/login_page.dart';
import 'package:crop_connect/my_colors.dart';
import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => redirectScreen)); //Todo: Change to redirect correctly
        },
        child: Container(
          decoration: BoxDecoration(color: AppColors.paleGreen),
          child: Row(
            children: [
              //Icon
              Image.asset(
                  iconRoute,
                  height: 30),
              //Name
              Row(
                children: [
                  Text(actionName),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
