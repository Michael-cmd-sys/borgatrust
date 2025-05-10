import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/app_theme.dart';
import '../../utils/constants.dart';
import '../../widgets/african_pattern_container.dart';
import '../../widgets/custom_button.dart';
import 'featured_service_card.dart';
import 'service_category_card.dart';
import 'top_service_provider_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // Set system UI overlay style for status bar
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        centerTitle: false,
        title: Image.asset(
          AssetPaths.logo,
          height: 40,
        ),
        actions: [
          IconButton(
            icon: const Stack(
              children: [
                Icon(Icons.notifications_outlined, size: 28),
                Positioned(
                  right: 0,
                  top: 0,
                  child: CircleAvatar(
                    backgroundColor: AppColors.primary,
                    radius: 8,
                    child: Text(
                      '3',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              // Handle notifications
            },
          ),
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                // Open profile or account settings
              },
              child: const CircleAvatar(
                backgroundColor: AppColors.primaryLight,
                radius: 18,
                child: Icon(
                  Icons.person,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: AfricanPatternContainer(
        opacity: 0.02,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroSection(),
              _buildSearchBar(),
              _buildServiceCategories(),
              _buildFeaturedServices(),
              _buildTopServiceProviders(),
            ],
          ),
        ),
      ),
      // Remove bottomNavigationBar property
    );
  }

  // 3. Remove the _buildBottomNavigationBar method since we no longer need it

  Widget _buildDrawer() {
    return Drawer(
      child: AfricanPatternContainer(
        opacity: 0.02,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: AppColors.primary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        child: Icon(
                          Icons.person,
                          color: AppColors.primary,
                          size: 36,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "John Doe",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "johndoe@example.com",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      // View profile
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.2),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "View Profile",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
              icon: Icons.home_outlined,
              title: "Home",
              onTap: () {
                Navigator.pop(context);
              },
              isSelected: true,
            ),
            _buildDrawerItem(
              icon: Icons.search,
              title: "Browse Services",
              onTap: () {
                Navigator.pop(context);
                // Navigate to browse services
              },
            ),
            _buildDrawerItem(
              icon: Icons.assignment_outlined,
              title: "My Orders",
              onTap: () {
                Navigator.pop(context);
                // Navigate to orders
              },
            ),
            _buildDrawerItem(
              icon: Icons.favorite_border,
              title: "Favorites",
              onTap: () {
                Navigator.pop(context);
                // Navigate to favorites
              },
            ),
            _buildDrawerItem(
              icon: Icons.message_outlined,
              title: "Messages",
              onTap: () {
                Navigator.pop(context);
                // Navigate to messages
              },
            ),
            const Divider(height: 32),
            _buildDrawerItem(
              icon: Icons.settings_outlined,
              title: "Settings",
              onTap: () {
                Navigator.pop(context);
                // Navigate to settings
              },
            ),
            _buildDrawerItem(
              icon: Icons.help_outline,
              title: "Help & Support",
              onTap: () {
                Navigator.pop(context);
                // Navigate to help & support
              },
            ),
            _buildDrawerItem(
              icon: Icons.logout,
              title: "Logout",
              onTap: () {
                Navigator.pop(context);
                // Handle logout
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.primary : AppColors.textMedium,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppColors.primary : AppColors.textDark,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      onTap: onTap,
      selected: isSelected,
      selectedTileColor: AppColors.primaryLight.withOpacity(0.1),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.primaryDark,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Connect with Trusted\nGhanaian Experts",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Find skilled professionals for all your service needs",
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: "Explore Services",
            onPressed: () {
              // Navigate to services exploration
            },
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            isPrimary: false,
            isFullWidth: false,
            height: 45,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          suffixIcon: IconButton(
            icon: const Icon(Icons.tune, color: AppColors.primary),
            onPressed: () {
              // Show filters
            },
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildServiceCategories() {
    final categories = [
      {"name": "Web Dev", "icon": Icons.computer, "count": 125},
      {"name": "Graphics", "icon": Icons.brush, "count": 78},
      {"name": "Writing", "icon": Icons.edit_document, "count": 94},
      {"name": "Events", "icon": Icons.event, "count": 56},
      {"name": "Translation", "icon": Icons.translate, "count": 42},
      {"name": "Legal", "icon": Icons.gavel, "count": 31},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Service Categories",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to all categories
                },
                child: const Text(
                  "See All",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Fix the categories horizontal scroll overflow
        SizedBox(
          height: 130, // Increased height to accommodate content
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return SizedBox(
                width: 90, // Fixed width for each category card
                child: ServiceCategoryCard(
                  name: category["name"] as String,
                  icon: category["icon"] as IconData,
                  count: category["count"] as int,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedServices() {
    final services = [
      {
        "title": "Professional Website Development",
        "provider": "TechSolutions Ghana",
        "image": "assets/images/featured_web_dev.jpg",
        "rating": 4.9,
        "reviews": 128,
        "price": 350,
      },
      {
        "title": "Logo Design & Brand Identity",
        "provider": "Creative Arts Accra",
        "image": "assets/images/featured_logo_design.jpg",
        "rating": 4.8,
        "reviews": 96,
        "price": 150,
      },
      {
        "title": "Content Writing & SEO",
        "provider": "Ghana WordCraft",
        "image": "assets/images/featured_content_writing.jpg",
        "rating": 4.7,
        "reviews": 75,
        "price": 120,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Featured Services",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to all featured services
                },
                child: const Text(
                  "See All",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Fix the featured services horizontal scroll overflow
        SizedBox(
          height: 300, // Increased height to accommodate content
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.75, // Responsive width
                child: FeaturedServiceCard(
                  title: service["title"] as String,
                  provider: service["provider"] as String,
                  imageAsset: service["image"] as String,
                  rating: service["rating"] as double,
                  reviews: service["reviews"] as int,
                  price: service["price"] as int,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTopServiceProviders() {
    final providers = [
      {
        "name": "Kwame Mensah",
        "specialty": "Web Development",
        "image": "assets/images/provider_web_dev.jpg",
        "rating": 4.9,
        "projects": 87,
      },
      {
        "name": "Ama Serwaa",
        "specialty": "Graphic Design",
        "image": "assets/images/provider_graphic_design.jpg",
        "rating": 4.8,
        "projects": 124,
      },
      {
        "name": "Kofi Adu",
        "specialty": "Content Writing",
        "image": "assets/images/provider_content_writing.jpg",
        "rating": 4.7,
        "projects": 56,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Top Service Providers",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to all providers
                },
                child: const Text(
                  "See All",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Fix vertical list overflow by using proper constraints
        ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: providers.length,
          itemBuilder: (context, index) {
            final provider = providers[index];
            return TopServiceProviderCard(
              name: provider["name"] as String,
              specialty: provider["specialty"] as String,
              imageAsset: provider["image"] as String,
              rating: provider["rating"] as double,
              projectsCompleted: provider["projects"] as int,
            );
          },
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
