// File: lib/presentation/screens/main_screen.dart
import 'package:flutter/material.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../data/repositories/user_service.dart'; // Import UserService
import './home/home_screen.dart';
import './explore/explore_screen.dart';
// PostJobScreen will be replaced by a bottom sheet trigger
// import './post_job/post_job_screen.dart';
import './messages/messages_screen.dart';
import './profile/profile_screen.dart';
// Import for the bottom sheet - will be created in the next step
// For now, we can use a placeholder or skip direct import if MainScreen only triggers it.
import '../../../shared/widgets/service/post_service_bottom_sheet.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final UserService _userService = UserService();

  // Define all possible screens
  final List<Widget> _allScreens = [
    const HomeScreen(),
    const ExploreScreen(),
    const MessagesScreen(),
    const ProfileScreen(),
  ];

  // Define navigation items for clients
  final List<BottomNavigationBarItem> _clientNavItems = [
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

  // Define navigation items for service agents
  final List<BottomNavigationBarItem> _serviceAgentNavItems = [
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
    const BottomNavigationBarItem(
      icon: Icon(Icons.add_business_outlined),
      activeIcon: Icon(Icons.add_business),
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

  @override
  Widget build(BuildContext context) {
    final bool isServiceAgent = _userService.currentUserRole == UserRole.serviceAgent;
    final navItems = isServiceAgent ? _serviceAgentNavItems : _clientNavItems;
    
    // Ensure current index is valid
    if (_currentIndex >= navItems.length) {
      _currentIndex = 0;
    }

    return Scaffold(
      body: IndexedStack(
        index: _getScreenIndex(_currentIndex, isServiceAgent),
        children: _allScreens,
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
          onTap: (index) => _onTabTapped(index, isServiceAgent),
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textLight,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
          items: navItems,
        ),
      ),
    );
  }

  int _getScreenIndex(int navIndex, bool isServiceAgent) {
    // Map navigation index to screen index
    if (isServiceAgent) {
      // Service agents: Home(0), Explore(1), PostService(2), Messages(3), Profile(4)
      // Screens: Home(0), Explore(1), Messages(2), Profile(3)
      if (navIndex == 2) return 2; // Post Service maps to Messages screen temporarily
      if (navIndex >= 3) return navIndex - 1; // Messages and Profile shift down
      return navIndex; // Home and Explore stay the same
    } else {
      // Clients: Home(0), Explore(1), Messages(2), Profile(3)
      // Screens: Home(0), Explore(1), Messages(2), Profile(3)
      return navIndex;
    }
  }

  void _onTabTapped(int index, bool isServiceAgent) {
    // Handle Post Service tab for service agents
    if (isServiceAgent && index == 2) {
      _showPostServiceBottomSheet();
      return;
    }

    setState(() {
      _currentIndex = index;
    });
  }

  void _showPostServiceBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (BuildContext sheetContext, ScrollController scrollController) {
            return PostServiceBottomSheet(scrollController: scrollController);
          },
        );
      },
    );
  }
}