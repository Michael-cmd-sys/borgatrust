// File: lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'presentation/screens/main_screen.dart';
import 'presentation/screens/onboarding/onboarding_screen.dart';
import 'presentation/screens/auth/auth_screen.dart';
import 'presentation/screens/home/home_screen.dart';
import 'presentation/screens/messages/messages_screen.dart';
import 'presentation/screens/explore/explore_screen.dart';
import 'presentation/screens/post_job/post_job_screen.dart';
import 'presentation/screens/profile/profile_screen.dart';
import 'shared/theme/app_theme.dart';
import 'data/repositories/user_service.dart';

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

  // Load authentication state
  final userService = UserService();
  await userService.loadAuthState();

  // Check if onboarding is completed
  final prefs = await SharedPreferences.getInstance();
  final onboardingCompleted = prefs.getBool('onboarding_completed') ?? false;

  runApp(MyApp(
    onboardingCompleted: onboardingCompleted,
    isAuthenticated: userService.isAuthenticated,
  ));
}

class MyApp extends StatelessWidget {
  final bool onboardingCompleted;
  final bool isAuthenticated;

  const MyApp({
    super.key, 
    required this.onboardingCompleted,
    required this.isAuthenticated,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BorgaTrust',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: _getInitialScreen(),
      routes: {
        '/auth': (context) => const AuthScreen(),
        '/main': (context) => const MainScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/messages': (context) => const MessagesScreen(),
        '/explore': (context) => const ExploreScreen(),
        '/post_job': (context) => const PostJobScreen(),
      },
    );
  }

  Widget _getInitialScreen() {
    if (!onboardingCompleted) {
      return const OnboardingScreen();
    }
    
    if (isAuthenticated) {
      return const MainScreen();
    }
    
    return const AuthScreen();
  }
}
