// lib/main.dart

import 'package:flutter/material.dart';
import 'features/auth/splash_screen.dart';
import 'features/auth/onboarding_screen.dart';
import 'core/constants/app_colors.dart';
import 'services/initialization_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BorgaTrust',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.secondary),
        scaffoldBackgroundColor: AppColors.background,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: AppColors.text), // Corrected: bodyMedium
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary, // Corrected: backgroundColor
          ),
        ),
      ),
      home: SplashScreenHandler(),
    );
  }
}

class SplashScreenHandler extends StatefulWidget {
  @override
  _SplashScreenHandlerState createState() => _SplashScreenHandlerState();
}

class _SplashScreenHandlerState extends State<SplashScreenHandler> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final InitializationService initializationService = InitializationService();
    await initializationService.initializeApp();

    // Navigate to the next screen after initialization
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => OnboardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}