import 'package:flutter/material.dart';

class OnboardingPageData {
  final String title;
  final String description;
  final String image;
  final Color backgroundColor;
  
  OnboardingPageData({
    required this.title,
    required this.description,
    required this.image,
    required this.backgroundColor,
  });
}

class OnboardingPage extends StatelessWidget {
  final OnboardingPageData data;
  
  const OnboardingPage({
    Key? key,
    required this.data,
  }) : super(key: key);
  
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
            imageSize = imageSize.clamp(100.0, 200.0); // Limit min/max size
            
            return Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: data.backgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    data.image,
                    height: imageSize,
                    width: imageSize,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  data.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 16),
                Text(
                  data.description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ],
            );
          }
        ),
      ),
    );
  }
}