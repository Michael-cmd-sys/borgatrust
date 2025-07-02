import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/custom_button.dart';
import '../auth/auth_screen.dart';
import 'onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  // New state for onboarding answers
  String? selectedRole;
  String? userPreference;

  // Add two new pages for role and preference selection
  late final List<Widget> onboardingPages;

  final List<OnboardingPageData> pages = [
    OnboardingPageData(
      title: "Welcome to BorgaTrust",
      subtitle: "Ghana's Premier Service Marketplace",
      description: "Connect with verified professionals and trusted service providers across Ghana. Your success is our priority.",
      image: AssetPaths.onboardingMission,
      backgroundColor: AppColors.primaryLight.withOpacity(0.1),
    ),
    OnboardingPageData(
      title: "AI-Powered Matching",
      subtitle: "Smart Recommendations",
      description: "Our advanced AI technology matches you with the perfect service providers based on your specific needs and preferences.",
      image: AssetPaths.onboardingAi,
      backgroundColor: AppColors.secondaryLight.withOpacity(0.1),
    ),
    OnboardingPageData(
      title: "Secure & Transparent",
      subtitle: "Blockchain-Backed Payments",
      description: "Experience secure, transparent transactions with our blockchain-powered payment system. Your financial security is guaranteed.",
      image: AssetPaths.onboardingBlockchain,
      backgroundColor: AppColors.primaryLight.withOpacity(0.1),
    ),
  ];

  @override
  void initState() {
    super.initState();
    onboardingPages = [
      _buildRoleSelectionPage(),
      _buildPreferencePage(),
      ...pages.map((page) => OnboardingPage(data: page)).toList(),
    ];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void completeOnboarding() async {
    // Dummy analytics: print answers
    print('Onboarding complete. Role: '
        '[33m[1m[4m${selectedRole ?? "Not selected"}[0m, '
        'Preference: [33m[1m[4m${userPreference ?? "Not provided"}[0m');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
    
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const AuthScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 300),
        ),
      );
    }
  }

  Widget _buildRoleSelectionPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Text(
            'Who are you?',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Select your role to personalize your experience.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textMedium,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          RadioListTile<String>(
            value: 'Client',
            groupValue: selectedRole,
            onChanged: (val) => setState(() => selectedRole = val),
            title: const Text('Client'),
            activeColor: AppColors.primary,
          ),
          RadioListTile<String>(
            value: 'Service Provider',
            groupValue: selectedRole,
            onChanged: (val) => setState(() => selectedRole = val),
            title: const Text('Service Provider'),
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencePage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Text(
            'What are you looking for?',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Let us know your main interest so we can tailor recommendations.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textMedium,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          DropdownButtonFormField<String>(
            value: userPreference,
            items: const [
              DropdownMenuItem(value: 'Web Development', child: Text('Web Development')),
              DropdownMenuItem(value: 'Graphic Design', child: Text('Graphic Design')),
              DropdownMenuItem(value: 'Content Writing', child: Text('Content Writing')),
              DropdownMenuItem(value: 'Legal Services', child: Text('Legal Services')),
              DropdownMenuItem(value: 'Events', child: Text('Events')),
              DropdownMenuItem(value: 'Translation', child: Text('Translation')),
              DropdownMenuItem(value: 'Other', child: Text('Other')),
            ],
            onChanged: (val) => setState(() => userPreference = val),
            decoration: const InputDecoration(
              labelText: 'Select your interest',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: TextButton(
                  onPressed: completeOnboarding,
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      color: AppColors.textMedium,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            
            // Page content
            Expanded(
              child: PageView.builder(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    isLastPage = index == onboardingPages.length - 1;
                  });
                },
                itemCount: onboardingPages.length,
                itemBuilder: (context, index) {
                  return onboardingPages[index];
                },
              ),
            ),
            
            // Bottom section with indicators and buttons
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Page indicators
                  SmoothPageIndicator(
                    controller: controller,
                    count: onboardingPages.length,
                    effect: const WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: AppColors.primary,
                      dotColor: AppColors.primaryLight,
                      spacing: 8,
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Navigation buttons
                  Row(
                    children: [
                      // Back button (only show if not on first page)
                      if (!isLastPage)
                        Expanded(
                          child: CustomButton(
                            text: "Previous",
                            onPressed: () {
                              controller.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            },
                            isPrimary: false,
                          ),
                        ),
                      
                      if (!isLastPage) const SizedBox(width: 16),
                      
                      // Next/Get Started button
                      Expanded(
                        flex: isLastPage ? 1 : 1,
                        child: CustomButton(
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
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

