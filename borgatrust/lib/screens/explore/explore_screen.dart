// File: lib/screens/explore/explore_screen.dart
import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../../widgets/african_pattern_container.dart';
import '../../widgets/custom_button.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

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
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              service["image"] as String,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 150,
                  width: double.infinity,
                  color: AppColors.primaryLight.withOpacity(0.3),
                  child: Center(
                    child: Icon(
                      _getCategoryIcon(service["category"] as String),
                      color: AppColors.primary,
                      size: 50,
                    ),
                  ),
                );
              },
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Service Title
                Text(
                  service["title"] as String,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Provider Name
                Row(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 16,
                      color: AppColors.textMedium,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      service["provider"] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textMedium,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 8),
                
                // Rating & Reviews
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 16,
                      color: Color(0xFFFFB800),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "${service["rating"]} (${service["reviews"]} reviews)",
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textMedium,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Price & View Details Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "GH₵ ${service["price"]}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    CustomButton(
                      text: "View Details",
                      onPressed: () {
                        // Navigate to service details
                      },
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      isPrimary: true,
                      isFullWidth: false,
                      height: 36,
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
