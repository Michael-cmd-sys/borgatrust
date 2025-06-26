// File: lib/screens/home/service_category_card.dart

import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

class ServiceCategoryCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final int count;

  const ServiceCategoryCard({
    super.key,
    required this.name,
    required this.icon,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // Maintain a fixed width for consistency in horizontal scroll
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4), // Adjusted margin
      padding: const EdgeInsets.symmetric(vertical: 12), // Added vertical padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1), // Softer shadow
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
        mainAxisSize: MainAxisSize.min,
        children: [
          Container( // Icon background remains similar
            width: 56, // Slightly smaller icon container
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withOpacity(0.15), // Lighter background for icon
              borderRadius: BorderRadius.circular(12), // Slightly less rounded
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 28, // Slightly smaller icon
            ),
          ),
          const SizedBox(height: 10), // Increased spacing
          Text(
            name,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
            textAlign: TextAlign.center,
            maxLines: 1, // Ensure name fits on one line
            overflow: TextOverflow.ellipsis, // Handle overflow for long names
          ),
          const SizedBox(height: 2),
          Text(
            "$count services",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textMedium, // Slightly darker than textLight
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}