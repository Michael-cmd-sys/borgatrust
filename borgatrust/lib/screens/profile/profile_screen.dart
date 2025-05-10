// File: lib/screens/profile/profile_screen.dart
import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../../widgets/african_pattern_container.dart';
import '../../widgets/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isEditing = false;
  
  // User profile data
  final Map<String, dynamic> _userData = {
    "name": "John Doe",
    "email": "johndoe@example.com",
    "phone": "+233 20 123 4567",
    "location": "Accra, Ghana",
    "bio": "Professional looking for quality services in web development and design.",
    "memberSince": "August 2023",
    "avatar": "assets/images/user_profile.jpg",
  };

  // Sample job history data
  final List<Map<String, dynamic>> _jobHistory = [
    {
      "title": "Website Redesign",
      "provider": "TechSolutions Ghana",
      "date": "April 2025",
      "status": "Completed",
      "amount": "GH₵ 550",
      "rating": 5.0,
    },
    {
      "title": "Logo Design",
      "provider": "Creative Arts Accra",
      "date": "March 2025",
      "status": "Completed",
      "amount": "GH₵ 150",
      "rating": 4.5,
    },
    {
      "title": "Content Writing for Blog",
      "provider": "Ghana WordCraft",
      "date": "February 2025",
      "status": "Completed",
      "amount": "GH₵ 120",
      "rating": 4.8,
    },
  ];

  // Sample active jobs data
  final List<Map<String, dynamic>> _activeJobs = [
    {
      "title": "Mobile App Development",
      "provider": "TechSolutions Ghana",
      "date": "Started May 2025",
      "status": "In Progress",
      "amount": "GH₵ 1200",
      "progress": 0.6,
    },
  ];

  // Sample saved services data
  final List<Map<String, dynamic>> _savedServices = [
    {
      "title": "Video Editing & Production",
      "provider": "Visual Media Ghana",
      "image": "assets/images/featured_video_editing.jpg",
      "rating": 4.7,
      "price": "GH₵ 300",
    },
    {
      "title": "Digital Marketing Services",
      "provider": "Accra Digital Marketing",
      "image": "assets/images/featured_digital_marketing.jpg",
      "rating": 4.6,
      "price": "GH₵ 250",
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        centerTitle: true,
        title: const Text(
          "My Profile",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.close : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: AfricanPatternContainer(
        opacity: 0.02,
        child: Column(
          children: [
            _buildProfileHeader(),
            _buildProfileStats(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildActiveJobsTab(),
                  _buildJobHistoryTab(),
                  _buildSavedServicesTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: AppColors.primaryLight,
                backgroundImage: AssetImage(_userData["avatar"]),
                onBackgroundImageError: (exception, stackTrace) {},
                child: const ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(60)),
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: AppColors.primary,
                  ),
                ),
              ),
              if (_isEditing)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          _isEditing
              ? _buildEditableField(_userData["name"], "Name", TextInputType.name)
              : Text(
                  _userData["name"],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
          const SizedBox(height: 8),
          _isEditing
              ? _buildEditableField(_userData["bio"], "Bio", TextInputType.multiline, maxLines: 3)
              : Text(
                  _userData["bio"],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textMedium,
                  ),
                ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                size: 16,
                color: AppColors.textLight,
              ),
              const SizedBox(width: 4),
              _isEditing
                  ? SizedBox(
                      width: 150,
                      child: TextField(
                        controller: TextEditingController(text: _userData["location"]),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(fontSize: 14),
                      ),
                    )
                  : Text(
                      _userData["location"],
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textMedium,
                      ),
                    ),
              const SizedBox(width: 16),
              Icon(
                Icons.calendar_today,
                size: 16,
                color: AppColors.textLight,
              ),
              const SizedBox(width: 4),
              Text(
                "Member since ${_userData["memberSince"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textMedium,
                ),
              ),
            ],
          ),
          if (_isEditing)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: CustomButton(
                text: "Save Changes",
                onPressed: () {
                  setState(() {
                    _isEditing = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Profile updated successfully!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                isPrimary: true,
                isFullWidth: false,
                height: 40,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEditableField(
    String initialValue,
    String hint,
    TextInputType keyboardType, {
    int maxLines = 1,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      width: maxLines > 1 ? double.infinity : null,
      child: TextField(
        controller: TextEditingController(text: initialValue),
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileStats() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem("15", "Orders"),
          _buildStatItem("8", "Completed"),
          _buildStatItem("4.8", "Avg. Rating"),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textMedium,
        indicatorColor: AppColors.primary,
        indicatorWeight: 3,
        tabs: const [
          Tab(text: "Active Jobs"),
          Tab(text: "History"),
          Tab(text: "Saved"),
        ],
      ),
    );
  }

  Widget _buildActiveJobsTab() {
    return _activeJobs.isEmpty
        ? _buildEmptyState(
            "No active jobs",
            "You don't have any active jobs at the moment.",
            Icons.work_outline,
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _activeJobs.length,
            itemBuilder: (context, index) {
              final job = _activeJobs[index];
              return _buildActiveJobCard(job);
            },
          );
  }

  Widget _buildActiveJobCard(Map<String, dynamic> job) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    job["title"],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    job["status"],
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              job["provider"],
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textMedium,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: AppColors.textLight,
                ),
                const SizedBox(width: 4),
                Text(
                  job["date"],
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textLight,
                  ),
                ),
                const Spacer(),
                Text(
                  job["amount"],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "Progress",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textMedium,
              ),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: job["progress"] as double,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // View job details
                  },
                  child: const Text("View Details"),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    // Contact provider
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                  ),
                  child: const Text("Contact"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobHistoryTab() {
    return _jobHistory.isEmpty
        ? _buildEmptyState(
            "No job history",
            "You haven't completed any jobs yet.",
            Icons.history,
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _jobHistory.length,
            itemBuilder: (context, index) {
              final job = _jobHistory[index];
              return _buildJobHistoryCard(job);
            },
          );
  }

  Widget _buildJobHistoryCard(Map<String, dynamic> job) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    job["title"],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    job["status"],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.green[700],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              job["provider"],
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textMedium,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: AppColors.textLight,
                ),
                const SizedBox(width: 4),
                Text(
                  job["date"],
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textLight,
                  ),
                ),
                const Spacer(),
                Text(
                  job["amount"],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text(
                  "Your Rating: ",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textMedium,
                  ),
                ),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < (job["rating"] as double).floor()
                          ? Icons.star
                          : index < (job["rating"] as double)
                              ? Icons.star_half
                              : Icons.star_border,
                      color: Colors.amber,
                      size: 16,
                    );
                  }),
                ),
                const SizedBox(width: 4),
                Text(
                  "(${job["rating"]})",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // View receipt
                  },
                  child: const Text("View Receipt"),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    // Book again
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                  ),
                  child: const Text("Book Again"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSavedServicesTab() {
    return _savedServices.isEmpty
        ? _buildEmptyState(
            "No saved services",
            "You haven't saved any services yet.",
            Icons.bookmark_border,
          )
        : GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: _savedServices.length,
            itemBuilder: (context, index) {
              final service = _savedServices[index];
              return _buildSavedServiceCard(service);
            },
          );
  }

  Widget _buildSavedServiceCard(Map<String, dynamic> service) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Stack(
              children: [
                Image.asset(
                  service["image"],
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 120,
                      color: AppColors.primaryLight,
                      child: const Icon(
                        Icons.image_not_supported,
                        color: AppColors.primary,
                      ),
                    );
                  },
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: InkWell(
                    onTap: () {
                      // Remove from saved
                      setState(() {
                        _savedServices.remove(service);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.bookmark,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Service info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service["title"],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  service["provider"],
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textMedium,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${service["rating"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMedium,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      service["price"],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String title, String message, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
            color: AppColors.textLight.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textMedium,
            ),
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: "Browse Services",
            onPressed: () {
              // Navigate to services
            },
            isPrimary: true,
            isFullWidth: false,
          ),
        ],
      ),
    );
  }
}