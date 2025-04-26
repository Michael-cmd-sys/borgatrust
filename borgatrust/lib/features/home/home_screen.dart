import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../discover/discover_screen.dart'; // Import DiscoverScreen
import '../profiles/profile_screen.dart'; // Import ProfileScreen

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final snackBar = SnackBar(
          content: const Text('Press back again to exit the app'),
          action: SnackBarAction(
            label: 'Exit',
            textColor: Colors.red,
            onPressed: () {
              SystemNavigator.pop();
              exit(0);
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(AppStrings.homeTitle, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                AppStrings.welcomeMessage,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                AppStrings.homeDescription,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Navigate to service list
                },
                child: const Text("Find Services"),
              ),
              const SizedBox(height: 24),
              const Text(
                "Popular Services",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    _buildServiceCard("Construction", "Build your dream home.", Icons.home_work),
                    _buildServiceCard("Education", "Learn from the best.", Icons.school),
                    _buildServiceCard("Logistics", "Reliable delivery services.", Icons.local_shipping),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(0, context),
      ),
    );
  }

  Widget _buildServiceCard(String title, String description, IconData icon) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title),
        subtitle: Text(description),
        onTap: () {
          // Navigate to service details
        },
      ),
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
        if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const DiscoverScreen()));
        }
        if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
        }
      },
    );
  }
}
