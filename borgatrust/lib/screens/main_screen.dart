// File: lib/screens/main_screen.dart
import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../../services/user_service.dart'; // Import UserService
import './home/home_screen.dart';
import './explore/explore_screen.dart';
// PostJobScreen will be replaced by a bottom sheet trigger
// import './post_job/post_job_screen.dart';
import './messages/messages_screen.dart';
import './profile/profile_screen.dart';
// Import for the bottom sheet - will be created in the next step
// For now, we can use a placeholder or skip direct import if MainScreen only triggers it.
import '../../widgets/service/post_service_bottom_sheet.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final UserService _userService = UserService();

  late List<Widget> _screens;
  late List<BottomNavigationBarItem> _navBarItems;

  @override
  void initState() {
    super.initState();
    _buildScreensAndNavBarItems();
  }

  void _buildScreensAndNavBarItems() {
    bool isServiceAgent = _userService.currentUserRole == UserRole.serviceAgent;

    _screens = [
      const HomeScreen(),
      const ExploreScreen(),
      // Placeholder for the "Post Service" screen if it's a dedicated page for agents,
      // or this slot can be skipped if it's only a bottom sheet.
      // If it's only a bottom sheet, the middle tab won't navigate to a PageView screen.
      // For now, let's keep it simple and assume the middle tab doesn't have a persistent screen in PageView
      // if it's a service agent and it's a bottom sheet.
      // If client, this slot is effectively unused or could be a placeholder.
      if (isServiceAgent)
        Container(), // Placeholder, this screen won't be directly navigated to by tab if it's a bottom sheet
      const MessagesScreen(),
      const ProfileScreen(),
    ];

    _navBarItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home),
        label: "Home",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.search),
        activeIcon: Icon(Icons.search),
        label: "Explore",
      ),
      if (isServiceAgent)
        const BottomNavigationBarItem(
          icon: Icon(Icons.add_business_outlined), // Or Icons.storefront
          activeIcon: Icon(Icons.add_business), // Or Icons.storefront
          label: "Post Service",
        ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.message_outlined),
        activeIcon: Icon(Icons.message),
        label: "Messages",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person_outline),
        activeIcon: Icon(Icons.person),
        label: "Profile",
      ),
    ];

    // Adjust _screens list if client (to maintain PageView indexing)
    // The middle "Post Job/Service" tab is index 2.
    // If the user is a client, we need a placeholder screen at index 2 if
    // other tabs (Messages, Profile) are to maintain their indices for PageView.
    // However, a simpler approach is to adjust indices in _onTabTapped.

    // Let's rebuild _screens based on what's actually visible to simplify PageView indexing.
    _screens = [
      const HomeScreen(),
      const ExploreScreen(),
    ];
    if (isServiceAgent) {
       // This screen is just a placeholder as the action is a bottom sheet.
       // Tapping this tab won't change the PageView.
      _screens.add(Container(key: const ValueKey("post_service_placeholder")));
    }
    _screens.addAll([
      const MessagesScreen(),
      const ProfileScreen(),
    ]);

  }

  // Call this if role changes during app lifecycle (e.g., after profile update or re-auth)
  // For now, it's mainly for initial build.
  void _updateNavForRole() {
    setState(() {
      _buildScreensAndNavBarItems();
      // Ensure current index is valid for the new set of tabs
      if (_currentIndex >= _navBarItems.length) {
        _currentIndex = _navBarItems.length - 1;
      }
      // If the "Post Service" tab was removed and was active, default to Home
      if (_userService.currentUserRole != UserRole.serviceAgent && _currentIndex == 2) {
          _currentIndex = 0;
          _pageController.jumpToPage(0); // Jump to home
      }
    });
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    bool isServiceAgent = _userService.currentUserRole == UserRole.serviceAgent;
    int targetScreenIndex = index;

    if (isServiceAgent && index == 2) { // "Post Service" tab for agent
      // Show bottom sheet
      _showPostServiceBottomSheet();
      // Do not change the page view's current screen, keep the user on the current page.
      // So, we don't call _pageController.animateToPage or change _currentIndex here.
      return;
    }

    // Adjust index for PageView if "Post Service" tab is not present (i.e., user is client)
    // and the tapped index is beyond where "Post Service" would have been.
    if (!isServiceAgent && index >= 2) {
      targetScreenIndex = index -1; // porque el tab de post service no existe para el cliente
    }


    _pageController.animateToPage(
      targetScreenIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    // The _currentIndex for BottomNavigationBar should always be the tapped `index`.
    // The `targetScreenIndex` is for the PageView.
    setState(() {
      _currentIndex = index;
    });
  }

  void _showPostServiceBottomSheet() {
    // Implementation of this bottom sheet will be in the next step.
    // For now, a placeholder.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to take up more height
      backgroundColor: Colors.transparent,
      builder: (context) {
        // This will be replaced by the actual PostServiceBottomSheet widget
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (BuildContext sheetContext, ScrollController scrollController) {
            // Pass the context and scrollController to the PostServiceBottomSheet
            return PostServiceBottomSheet(scrollController: scrollController);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Rebuild items on each build to reflect role changes if any (though initState handles initial)
    // For a more dynamic app, you'd use a state management solution to trigger this.
    _buildScreensAndNavBarItems();

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
        onPageChanged: (screenIndex) { // This is the PageView's screenIndex
           // We need to map screenIndex back to navBar index
          bool isServiceAgent = _userService.currentUserRole == UserRole.serviceAgent;
          int navBarIndex = screenIndex;
          if (!isServiceAgent && screenIndex >= 2) { // If client and screen index is for Messages or Profile
            navBarIndex = screenIndex + 1;
          }
          // If service agent and the "Post Service" placeholder was somehow directly navigated to (shouldn't happen via tabs)
          // this logic might need refinement, but tab interaction is primary.
          // The key is that _currentIndex reflects the actual tapped BottomNavBarItem index.

          // This onPageChanged might not be strictly necessary if all navigation is via _onTabTapped
          // and _currentIndex is correctly set there.
          // However, if _pageController could be changed externally, this would be important.
          // For now, let's ensure _currentIndex reflects the visual tab.
          setState(() {
             _currentIndex = navBarIndex;
          });
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textLight,
          selectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          unselectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
          items: _navBarItems,
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Rebuild items on each build to reflect role changes if any (though initState handles initial)
    // For a more dynamic app, you'd use a state management solution to trigger this.
    _buildScreensAndNavBarItems();

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
        onPageChanged: (screenIndex) { // This is the PageView's screenIndex
           // We need to map screenIndex back to navBar index
          bool isServiceAgent = _userService.currentUserRole == UserRole.serviceAgent;
          int navBarIndex = screenIndex;
          if (!isServiceAgent && screenIndex >= 2) { // If client and screen index is for Messages or Profile
            navBarIndex = screenIndex + 1;
          }
          // If service agent and the "Post Service" placeholder was somehow directly navigated to (shouldn't happen via tabs)
          // this logic might need refinement, but tab interaction is primary.
          // The key is that _currentIndex reflects the actual tapped BottomNavBarItem index.

          // This onPageChanged might not be strictly necessary if all navigation is via _onTabTapped
          // and _currentIndex is correctly set there.
          // However, if _pageController could be changed externally, this would be important.
          // For now, let's ensure _currentIndex reflects the visual tab.
          setState(() {
             _currentIndex = navBarIndex;
          });
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textLight,
          selectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          unselectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
          items: _navBarItems,
        ),
      ),
    );
  }
}
