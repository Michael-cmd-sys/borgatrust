// File: lib/screens/explore/explore_screen.dart
import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../../widgets/african_pattern_container.dart';
import '../../widgets/custom_button.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final List<String> _filterCategories = [
    "All",
    "Web Dev",
    "Graphics",
    "Writing",
    "Events",
    "Translation",
    "Legal",
  ];

  String _selectedCategory = "All";

  final List<Map<String, dynamic>> _services = [
    {
      "title": "Professional Website Development",
      "provider": "TechSolutions Ghana",
      "image": "assets/images/featured_web_dev.jpg",
      "rating": 4.9,
      "reviews": 128,
      "price": 350,
      "category": "Web Dev",
    },
    {
      "title": "Logo Design & Brand Identity",
      "provider": "Creative Arts Accra",
      "image": "assets/images/featured_logo_design.jpg",
      "rating": 4.8,
      "reviews": 96,
      "price": 150,
      "category": "Graphics",
    },
    {
      "title": "Content Writing & SEO",
      "provider": "Ghana WordCraft",
      "image": "assets/images/featured_content_writing.jpg",
      "rating": 4.7,
      "reviews": 75,
      "price": 120,
      "category": "Writing",
    },
    {
      "title": "Event Planning & Management",
      "provider": "Accra Events Ltd",
      "image": "assets/images/featured_events.jpg",
      "rating": 4.6,
      "reviews": 64,
      "price": 500,
      "category": "Events",
    },
    {
      "title": "English to Twi Translation",
      "provider": "Ghana Translators",
      "image": "assets/images/featured_translation.jpg",
      "rating": 4.5,
      "reviews": 42,
      "price": 80,
      "category": "Translation",
    },
    {
      "title": "Legal Document Preparation",
      "provider": "LegalEase Ghana",
      "image": "assets/images/featured_legal.jpg",
      "rating": 4.8,
      "reviews": 56,
      "price": 200,
      "category": "Legal",
    },
  ];

  List<Map<String, dynamic>> get _filteredServices {
    if (_selectedCategory == "All") {
      return _services;
    } else {
      return _services.where((service) => service["category"] == _selectedCategory).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        centerTitle: true,
        title: const Text(
          "Explore Services",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () {
              // Show filter options
            },
          ),
        ],
      ),
      body: AfricanPatternContainer(
        opacity: 0.02,
        child: Column(
          children: [
            _buildSearchBar(),
            _buildCategoryFilter(),
            Expanded(
              child: _buildServicesList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search for services, providers...",
          hintStyle: TextStyle(color: AppColors.textLight, fontSize: 14),
          prefixIcon: const Icon(Icons.search, color: AppColors.textLight),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filterCategories.length,
        itemBuilder: (context, index) {
          final category = _filterCategories[index];
          final isSelected = category == _selectedCategory;
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = category;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.white : AppColors.textMedium,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildServicesList() {
    return _filteredServices.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.search_off,
                  size: 70,
                  color: AppColors.textLight,
                ),
                const SizedBox(height: 16),
                Text(
                  "No services found for \"$_selectedCategory\"",
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textMedium,
                  ),
                ),
              ],
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _filteredServices.length,
            itemBuilder: (context, index) {
              final service = _filteredServices[index];
              return _buildServiceCard(service);
            },
          );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return Card( // Using Card widget for standard elevation and shape
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3, // Subtle elevation
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Consistent rounding
      child: InkWell( // Make the whole card tappable
        onTap: () {
          // TODO: Navigate to service details screen
          print("Tapped on service: ${service['title']}");
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                service["image"] as String,
                height: 160, // Slightly taller image
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 160,
                    width: double.infinity,
                    color: AppColors.primaryLight.withOpacity(0.2),
                    child: Center(
                      child: Icon(
                        _getCategoryIcon(service["category"] as String),
                        color: AppColors.primary.withOpacity(0.7),
                        size: 60,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12), // Reduced padding slightly for compactness
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service["title"] as String,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                    maxLines: 2, // Ensure title doesn't overflow excessively
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row( // Provider info with icon
                    children: [
                      Icon(Icons.storefront_outlined, size: 16, color: AppColors.textMedium),
                      const SizedBox(width: 6),
                      Expanded( // Allow provider name to take space and ellipsis if needed
                        child: Text(
                          service["provider"] as String,
                           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.textMedium,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row( // Rating
                        children: [
                          const Icon(Icons.star, size: 18, color: Color(0xFFFFB800)),
                          const SizedBox(width: 4),
                          Text(
                            (service["rating"] as double).toStringAsFixed(1), // Formatted rating
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(width: 4),
                           Text(
                            "(${service["reviews"]} reviews)",
                             style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textLight,
                              ),
                          ),
                        ],
                      ),
                      Text( // Price
                        "GH₵ ${service["price"]}",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  CustomButton( // "View Details" button made less prominent, card itself is tappable
                    text: "View Details",
                    onPressed: () {
                       // TODO: Navigate to service details screen
                       print("Tapped View Details for: ${service['title']}");
                    },
                    isPrimary: false, // Use outlined style
                    isFullWidth: true, // Make it full width for this card layout
                    height: 38,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Web Dev":
        return Icons.computer;
      case "Graphics":
        return Icons.brush;
      case "Writing":
        return Icons.edit_document;
      case "Events":
        return Icons.event;
      case "Translation":
        return Icons.translate;
      case "Legal":
        return Icons.gavel;
      default:
        return Icons.work;
    }
  }
}
