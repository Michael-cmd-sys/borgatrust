import 'package:flutter/material.dart';
import 'package:borgatrust/widgets/custom_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BorgaTrust'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Ensure the column doesn't take unnecessary space
          children: [
            const Text(
              'Welcome to BorgaTrust!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0A5F44),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Your trusted blockchain and AI solutions.',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.2, // Adjust aspect ratio to fit better
                children: [
                  CustomCard(
                    title: 'Blockchain Services',
                    icon: Icons.link, // Represents connections/links in a chain
                    onTap: () {
                      _showFeatureComingSoon(context, 'Blockchain Services');
                    },
                  ),
                  CustomCard(
                    title: 'AI Solutions',
                    icon: Icons.lightbulb, // Represents innovation/intelligence
                    onTap: () {
                      _showFeatureComingSoon(context, 'AI Solutions');
                    },
                  ),
                  CustomCard(
                    title: 'User Dashboard',
                    icon: Icons.dashboard,
                    onTap: () {
                      _showFeatureComingSoon(context, 'User Dashboard');
                    },
                  ),
                  CustomCard(
                    title: 'Settings',
                    icon: Icons.settings,
                    onTap: () {
                      _showFeatureComingSoon(context, 'Settings');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFeatureComingSoon(BuildContext context, String featureName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$featureName is coming soon!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}