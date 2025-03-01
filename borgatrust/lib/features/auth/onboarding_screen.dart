import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

class OnboardingScreen extends StatefulWidget {
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
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.secondary,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );
                    },
                    child: Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(String title, String description, String imagePath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(imagePath, height: 150),
        SizedBox(height: 20),
        Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}