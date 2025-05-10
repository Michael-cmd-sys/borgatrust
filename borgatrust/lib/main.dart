// File: lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/main_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/auth/auth_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/messages/messages_screen.dart';
import 'screens/explore/explore_screen.dart';
import 'screens/post_job/post_job_screen.dart';
import 'screens/profile/profile_screen.dart'; // Import ProfileScreen
import 'utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // Check if onboarding is completed
  final prefs = await SharedPreferences.getInstance();
  final showOnboarding = prefs.getBool('showOnboarding') ?? true;

  runApp(MyApp(showOnboarding: showOnboarding));
}

class MyApp extends StatelessWidget {
  final bool showOnboarding;

  const MyApp({Key? key, required this.showOnboarding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Borga Trust',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: showOnboarding ? const OnboardingScreen() : const AuthScreen(),
      routes: {
        '/auth': (context) => const AuthScreen(),
        '/main': (context)=> const MainScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(), // Add route for ProfileScreen
        '/messages': (context) => const MessagesScreen(),
        'explore': (context) => const ExploreScreen(),
        '/post_job': (context) => const PostJobScreen(),
      },
    );
  }
}
