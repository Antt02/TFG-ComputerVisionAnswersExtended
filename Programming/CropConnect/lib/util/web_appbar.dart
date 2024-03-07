import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../my_colors.dart';

class WebAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    assert(user != null);
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: AppBar(
        centerTitle: false,
        backgroundColor: AppColors.bone,
        elevation: 5.0,
        title: Row(
          children: [
            const Text('CropConnect',
              style: TextStyle(
                fontFamily: "SanFrancisco",
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: -2,
              ),
            ),
            const SizedBox(width: 400),
            const Text('About Us',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: 24,
                letterSpacing: -2,
              ),
            ),
            const SizedBox(width: 200),
            const Text('Our Services',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: 24,
                letterSpacing: -2,
              ),
            ),
            const SizedBox(width: 200),
            const Text('Contact Us',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: 24,
                letterSpacing: -2,
              ),
            ),
            const SizedBox(width: 200),
            Text("${user?.displayName}",
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: 24,
                letterSpacing: -2,
              ),
            ),
            Container(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: const [0.4, 0.6],
                    colors: [
                      AppColors.darkGreen2,
                      AppColors.baseGreen,
                    ],
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontFamily: "SanFrancisco",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            )
          ],

        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
