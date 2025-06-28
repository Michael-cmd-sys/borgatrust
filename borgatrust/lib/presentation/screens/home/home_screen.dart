import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/african_pattern_container.dart';
import '../../../shared/widgets/custom_button.dart';
import 'featured_service_card.dart';
import 'service_category_card.dart';
import 'top_service_provider_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.3),
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
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideX(begin: 0.3),
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
            ).animate().fadeIn(delay: 400.ms, duration: 600.ms).slideX(begin: 0.3),
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: AfricanPatternContainer(
        opacity: 0.02,
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeroSection().animate().fadeIn(delay: 600.ms, duration: 800.ms).slideY(begin: 0.3),
                      const SizedBox(height: 24),
                      _buildSearchBar().animate().fadeIn(delay: 800.ms, duration: 600.ms).slideY(begin: 0.2),
                      const SizedBox(height: 24),
                      _buildServiceCategories().animate().fadeIn(delay: 1000.ms, duration: 600.ms).slideY(begin: 0.2),
                      const SizedBox(height: 24),
                      _buildFeaturedServices().animate().fadeIn(delay: 1200.ms, duration: 600.ms).slideY(begin: 0.2),
                      const SizedBox(height: 24),
                      _buildTopServiceProviders().animate().fadeIn(delay: 1400.ms, duration: 600.ms).slideY(begin: 0.2),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
            _buildDrawerItem(
              icon: Icons.settings_outlined,
              title: "Settings",
              onTap: () {
                Navigator.pop(context);
                // Navigate to settings
              },
            ),
            const Divider(),
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
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Find Trusted Services",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Connect with verified professionals across Ghana",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: "Explore Services",
            onPressed: () {
              // Navigate to explore screen
              Navigator.pushNamed(context, '/explore');
            },
            backgroundColor: Colors.white,
            foregroundColor: AppColors.primary,
            isFullWidth: false,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.textLight),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search for services...",
                border: InputBorder.none,
                hintStyle: TextStyle(color: AppColors.textLight),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: AppColors.textLight),
            onPressed: () {
              // Show filters
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Service Categories",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            children: [
              ServiceCategoryCard(
                name: "Web Development",
                icon: Icons.web,
                count: 125,
              ),
              const SizedBox(width: 12),
              ServiceCategoryCard(
                name: "Graphic Design",
                icon: Icons.design_services,
                count: 78,
              ),
              const SizedBox(width: 12),
              ServiceCategoryCard(
                name: "Content Writing",
                icon: Icons.edit,
                count: 94,
              ),
              const SizedBox(width: 12),
              ServiceCategoryCard(
                name: "Legal Services",
                icon: Icons.gavel,
                count: 31,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedServices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Featured Services",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            TextButton(
              onPressed: () {
                // View all featured services
              },
              child: const Text(
                "View All",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 280,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              FeaturedServiceCard(
                title: "Professional Website Design",
                provider: "Kwame Web Solutions",
                rating: 4.8,
                reviews: 128,
                price: 2500,
                imageAsset: "assets/images/featured_web_dev.jpg",
              ),
              const SizedBox(width: 16),
              FeaturedServiceCard(
                title: "Logo & Brand Identity",
                provider: "Ama Design Studio",
                rating: 4.9,
                reviews: 96,
                price: 800,
                imageAsset: "assets/images/featured_logo_design.jpg",
              ),
              const SizedBox(width: 16),
              FeaturedServiceCard(
                title: "Content Writing Services",
                provider: "Kofi Content Pro",
                rating: 4.7,
                reviews: 75,
                price: 500,
                imageAsset: "assets/images/featured_content_writing.jpg",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTopServiceProviders() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Top Service Providers",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            TextButton(
              onPressed: () {
                // View all providers
              },
              child: const Text(
                "View All",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              TopServiceProviderCard(
                name: "Kwame Mensah",
                specialty: "Web Developer",
                rating: 4.9,
                projectsCompleted: 127,
                imageAsset: "assets/images/provider_web_dev.jpg",
              ),
              const SizedBox(width: 16),
              TopServiceProviderCard(
                name: "Ama Serwaa",
                specialty: "Graphic Designer",
                rating: 4.8,
                projectsCompleted: 89,
                imageAsset: "assets/images/provider_graphic_design.jpg",
              ),
              const SizedBox(width: 16),
              TopServiceProviderCard(
                name: "Kofi Adu",
                specialty: "Content Writer",
                rating: 4.7,
                projectsCompleted: 156,
                imageAsset: "assets/images/provider_content_writing.jpg",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
