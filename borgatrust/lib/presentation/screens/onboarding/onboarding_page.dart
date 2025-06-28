import 'package:flutter/material.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';

class OnboardingPageData {
  final String title;
  final String? subtitle;
  final String description;
  final String image;
  final Color backgroundColor;
  
  OnboardingPageData({
    required this.title,
    this.subtitle,
    required this.description,
    required this.image,
    required this.backgroundColor,
  });
}

class OnboardingPage extends StatelessWidget {
  final OnboardingPageData data;
  
  const OnboardingPage({
    super.key,
    required this.data,
  });
  
  @override
  Widget build(BuildContext context) {
    // Use SingleChildScrollView to handle potential overflows
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Calculate appropriate image size based on screen width
            double imageSize = constraints.maxWidth * 0.4;
            imageSize = imageSize.clamp(120.0, 240.0); // Limit min/max size
            
            return Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                
                // Image container
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: data.backgroundColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    data.image,
                    height: imageSize,
                    width: imageSize,
                    fit: BoxFit.contain,
                  ),
                ),
                
                const SizedBox(height: 48),
                
                // Title
                Text(
                  data.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                
                // Subtitle (if provided)
                if (data.subtitle != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    data.subtitle!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                
                const SizedBox(height: 24),
                
                // Description
                Text(
                  data.description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textMedium,
                    height: 1.6,
                  ),
                ),
                
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              ],
            );
          }
        ),
      ),
    );
  }
}