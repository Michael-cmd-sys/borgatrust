import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

class FeaturedServiceCard extends StatelessWidget {
  final String title;
  final String provider;
  final String imageAsset;
  final double rating;
  final int reviews;
  final int price;

  const FeaturedServiceCard({
    super.key,
    required this.title,
    required this.provider,
    required this.imageAsset,
    required this.rating,
    required this.reviews,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260, // Slightly increased width for better content fit
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8), // Consistent margin
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // Consistent border radius
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.asset(
              imageAsset,
              height: 130,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          
          // Service Details
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                  maxLines: 2, // Keep title to 2 lines
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Color(0xFFFFB800), size: 18), // Slightly larger star
                    const SizedBox(width: 4),
                    Text(
                      rating.toStringAsFixed(1), // Format rating to 1 decimal place
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "($reviews reviews)", // More descriptive
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textMedium,
                          ),
                    ),
                  ],
                ),
                const Spacer(), // Use Spacer to push price to the bottom
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center, // Align items vertically
                  children: [
                    Text(
                      "GH₵ $price", // Assuming price is an int, format as needed
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    IconButton(
                      icon: Icon(
                        // TODO: Add logic to show favorite_filled if service is favorited
                        Icons.favorite_outline,
                        color: AppColors.textLight,
                        size: 24, // Slightly larger icon
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        // TODO: Implement add/remove to favorites
                      },
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