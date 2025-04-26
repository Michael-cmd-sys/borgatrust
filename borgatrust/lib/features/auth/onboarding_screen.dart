import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/onboarding_bloc.dart';
import 'signup_screen.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < 3; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 4.0,
      width: isActive ? 40.0 : 32.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.orange : Colors.white.withOpacity(0.3),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: <Widget>[
                _buildPage(
                  AppStrings.onboardingMissionTitle,
                  AppStrings.onboardingMissionDescription,
                  AppStrings.onboardingMissionImagePath,
                ),
                _buildPage(
                  AppStrings.onboardingAiTitle,
                  AppStrings.onboardingAiDescription,
                  AppStrings.onboardingAiImagePath,
                ),
                _buildPage(
                  AppStrings.onboardingBlockchainTitle,
                  AppStrings.onboardingBlockchainDescription,
                  AppStrings.onboardingBlockchainImagePath,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(String title, String description, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Gradient overlay for better text readability
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),

          // Skip button at top right
          Positioned(
            top: 32,
            right: 16,
            child: TextButton(
              onPressed: () {
                _pageController.animateToPage(
                  2,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(flex: 3),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                const SizedBox(height: 25),

                // Navigation button (Next or Finish)
                _currentPage < 2
                    ? SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Next',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<OnboardingBloc>().add(OnboardingCompleted());
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SignupScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Finish',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
