import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../home/home_screen.dart'; // Import HomeScreen
import '../discover/discover_screen.dart'; // Import DiscoverScreen

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.secondary,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text("John Doe", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text("johndoe@example.com"),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.settings, color: AppColors.primary),
              title: const Text("Settings"),
              onTap: () {
                // Navigate to settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.history, color: AppColors.primary),
              title: const Text("Order History"),
              onTap: () {
                // Navigate to order history
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(2, context),
    );
  }

  Widget _buildBottomNavigationBar(int currentIndex, BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Discover',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        if (index == 0) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        }
        if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const DiscoverScreen()));
        }
      },
    );
  }
}
