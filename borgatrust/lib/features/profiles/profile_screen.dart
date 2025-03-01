import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../home/home_screen.dart'; // Import HomeScreen
import '../discover/discover_screen.dart'; // Import DiscoverScreen


class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.secondary,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            SizedBox(height: 16),
            Text("John Doe", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("johndoe@example.com"),
            SizedBox(height: 24),
            ListTile(
              leading: Icon(Icons.settings, color: AppColors.primary),
              title: Text("Settings"),
              onTap: () {
                // Navigate to settings
              },
            ),
            ListTile(
              leading: Icon(Icons.history, color: AppColors.primary),
              title: Text("Order History"),
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
  Widget _buildBottomNavigationBar(int currentIndex,BuildContext context){
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
        if(index == 0){
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
        if(index == 1){
          Navigator.push(context, MaterialPageRoute(builder: (context) => DiscoverScreen()));
        }
      },
    );
  }
}