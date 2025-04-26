import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../home/home_screen.dart'; // Import HomeScreen
import '../profiles/profile_screen.dart'; // Import ProfileScreen

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Discover Services')),
      body: ListView(
        children: <Widget>[
          _buildServiceItem("Construction", Icons.home_work, context),
          _buildServiceItem("Education", Icons.school, context),
          _buildServiceItem("Logistics", Icons.local_shipping, context),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(1, context),
    );
  }

  Widget _buildServiceItem(String title, IconData icon, BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      onTap: () {
        // Navigate to service list or details
      },
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
        if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
        }
      },
    );
  }
}
