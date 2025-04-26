import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/onboarding_screen.dart';
import 'package:borgatrust/bloc/onboarding_bloc.dart'; // Update path if needed
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OnboardingBloc>(
          create: (context) => OnboardingBloc(),
        ),
        // Add other BlocProviders here if needed
      ],
      child: MaterialApp(
        title: 'BorgaTrust',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const OnboardingScreen(),
      ),
    );
  }
}
