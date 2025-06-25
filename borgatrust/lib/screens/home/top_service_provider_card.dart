import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

class TopServiceProviderCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String imageAsset;
  final double rating;
  final int projectsCompleted;

  const TopServiceProviderCard({
    Key? key,
    required this.name,
    required this.specialty,
    required this.imageAsset,
    required this.rating,
    required this.projectsCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Provider Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imageAsset,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 80,
                  color: AppColors.primaryLight.withOpacity(0.3),
                  child: const Icon(
                    Icons.person,
                    color: AppColors.primary,
                    size: 40,
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Provider Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Provider Name - Wrap with Expanded to prevent overflow
                    Expanded(
                      child: Text(
                        name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8), // Increased spacing
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Color(0xFFFFB800), size: 18), // Slightly larger
                        const SizedBox(width: 3),
                        Text(
                          rating.toStringAsFixed(1), // Formatted rating
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4), // Reduced spacing
                Text(
                  specialty,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textMedium,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8), // Adjusted spacing
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded( // Allow projects count to take available space but also shrink
                      flex: 2, // Give it more tendency to expand
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.cases_outlined, size: 16, color: AppColors.primary), // Changed icon
                          const SizedBox(width: 4),
                          Text(
                            "$projectsCompleted Projects", // Combined text
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textMedium,
                                  fontWeight: FontWeight.w500,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton( // Changed to ElevatedButton for more prominence
                      onPressed: () {
                        // TODO: Navigate to provider profile
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryLight.withOpacity(0.25),
                        foregroundColor: AppColors.primary,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), // Adjusted padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        "View Profile",
                        style: Theme.of(context).textTheme.labelMedium?.copyWith( // Use labelMedium for button text
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}