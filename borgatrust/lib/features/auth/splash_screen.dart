// lib/features/auth/splash_screen.dart

import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary, // Or any background color you prefer
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              AppStrings.appLogoPath, // Assuming you have a logo path in app_strings
              height: 150, // Adjust the size as needed
            ),
            const SizedBox(height: 20),
            const Text(
              'BorgaTrust', // Your app name
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
