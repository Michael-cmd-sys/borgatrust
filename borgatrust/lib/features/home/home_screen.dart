import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../discover/discover_screen.dart'; // Import DiscoverScreen
import '../profiles/profile_screen.dart'; // Import ProfileScreen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.homeTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              AppStrings.welcomeMessage,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              AppStrings.homeDescription,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Navigate to service list
              },
              child: Text("Find Services"),
            ),
            SizedBox(height: 24),
            Text(
              "Popular Services",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
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
    );
  }

  Widget _buildServiceCard(String title, String description, IconData icon) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
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
        if(index == 1){
          Navigator.push(context, MaterialPageRoute(builder: (context) => DiscoverScreen()));
        }
        if(index == 2){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
        }
      },
    );
  }
}