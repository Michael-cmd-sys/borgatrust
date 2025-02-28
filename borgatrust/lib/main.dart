import 'package:flutter/material.dart';
import 'features/splash/splash_screen.dart';
import 'package:borgatrust/themes/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BorgaTrust',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(), // Start with the splash screen
    );
  }
}