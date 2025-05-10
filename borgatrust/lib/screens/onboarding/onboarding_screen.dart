import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../utils/app_theme.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';
import '../auth/auth_screen.dart';
import 'onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  final List<OnboardingPageData> pages = [
    OnboardingPageData(
      title: "Connect with Trusted Ghanaian Service Providers",
      description: "Access verified professionals from Ghana for all your service needs with ease and confidence.",
      image: AssetPaths.onboardingMission,
      backgroundColor: AppColors.primaryLight.withOpacity(0.2),
    ),
    OnboardingPageData(
      title: "Powered by Advanced AI Technology",
      description: "Our AI-powered platform matches you with the best service providers based on your specific needs and preferences.",
      image: AssetPaths.onboardingAi,
      backgroundColor: AppColors.secondaryLight.withOpacity(0.2),
    ),
    OnboardingPageData(
      title: "Secure Payments & Transactions",
      description: "Experience secure and transparent payments backed by blockchain technology for complete peace of mind.",
      image: AssetPaths.onboardingBlockchain,
      backgroundColor: AppColors.primaryLight.withOpacity(0.2),
    ),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showOnboarding', false);
    
    if (!mounted) return;
    
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const AuthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.background,
              AppColors.background,
              AppColors.primaryLight.withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      AssetPaths.logo,
                      height: 40,
                    ),
                    TextButton(
                      onPressed: () => completeOnboarding(),
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                          color: AppColors.textMedium,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  onPageChanged: (index) {
                    setState(() {
                      isLastPage = index == pages.length - 1;
                    });
                  },
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    return OnboardingPage(data: pages[index]);
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SmoothPageIndicator(
                      controller: controller,
                      count: pages.length,
                      effect: const WormEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                        activeDotColor: AppColors.primary,
                        dotColor: AppColors.primaryLight,
                      ),
                    ),
                    const SizedBox(height: 32),
                    CustomButton(
                      text: isLastPage ? "Get Started" : "Next",
                      onPressed: () {
                        if (isLastPage) {
                          completeOnboarding();
                        } else {
                          controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                    if (!isLastPage) ...[
                      const SizedBox(height: 16),
                      CustomButton(
                        text: "Sign In",
                        onPressed: () => completeOnboarding(),
                        isPrimary: false,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

