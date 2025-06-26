// File: lib/screens/profile/profile_screen.dart
import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../../widgets/african_pattern_container.dart';
import '../../widgets/custom_button.dart';
import '../../services/user_service.dart'; // Import UserService
import '../../widgets/custom_text_field.dart'; // Import CustomTextField for editable fields

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isEditing = false;
  final UserService _userService = UserService();
  late Map<String, dynamic> _userData; // To be fetched from UserService

  // Controllers for editable fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();


  // Sample job history data (Client-specific)
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

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
      if (_isEditing) {
        // Populate controllers when entering edit mode
        _nameController.text = _userData['name'] ?? '';
        _bioController.text = _userData['bio'] ?? '';
        _locationController.text = _userData['location'] ?? '';
        _phoneController.text = _userData['phone'] ?? '';
         if (_userService.currentUserRole == UserRole.serviceAgent) {
            _businessNameController.text = _userData['businessName'] ?? '';
        }
      }
    });
  }

  void _saveChanges() {
     // Basic validation example
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Name cannot be empty."), backgroundColor: AppColors.error),
      );
      return;
    }

    setState(() {
      _isEditing = false;
      // NOTE: In a real app, this data would be saved to a backend.
      // Here, we're just updating the local _userData map for mock purposes.
      // This local _userData will be re-fetched via _userService.getMockUserData()
      // if the screen rebuilds or role changes, so direct mutation here is for immediate UI update only.
      _userData['name'] = _nameController.text;
      _userData['bio'] = _bioController.text;
      _userData['location'] = _locationController.text;
      _userData['phone'] = _phoneController.text;
      if (_userService.currentUserRole == UserRole.serviceAgent) {
         _userData['businessName'] = _businessNameController.text;
         // Potentially update the UserService's mock data if it were designed to be mutable,
         // or rely on re-fetching for a "clean" state if roles are toggled.
      }
       print("Saving changes: $_userData"); // For debugging
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Profile updated successfully! (Mock)"),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Service Agent Tabs - Placeholders for now
  Widget _buildMyServicesTab() {
    // TODO: Fetch and display services offered by the agent
    return _buildEmptyState(
      "My Offered Services",
      "You haven't listed any services yet. Add your first service!",
      Icons.list_alt_outlined,
      showBrowseButton: false, // Agent should add services, not browse
      actionButton: CustomButton(
        text: "Add New Service",
        onPressed: () {
          // TODO: Trigger action to add a new service (e.g., show bottom sheet or navigate)
          // This could potentially re-use or adapt the PostServiceBottomSheet
           ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Action: Add new service (Not implemented yet)")),
          );
        },
        isPrimary: true,
        isFullWidth: false,
      ),
    );
  }

  Widget _buildServiceRequestsTab() {
    // TODO: Fetch and display service requests from clients
    return _buildEmptyState(
      "Client Service Requests",
      "No pending service requests from clients at the moment.",
      Icons.mark_email_read_outlined, // Or Icons.inbox_outlined
      showBrowseButton: false,
    );
  }

  Widget _buildAgentPerformanceTab() {
    // TODO: Display agent's ratings, earnings, statistics
    return _buildEmptyState(
      "My Performance",
      "Your performance metrics (ratings, earnings, etc.) will appear here.",
      Icons.insights_outlined, // Or Icons.bar_chart_outlined
      showBrowseButton: false,
    );
  }


  Widget _buildEmptyState(String title, String message, IconData icon, {bool showBrowseButton = true, Widget? actionButton}) {
    return Center(
      child: Padding( // Added padding around the empty state content
        padding: const EdgeInsets.all(24.0),
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
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textMedium),
            ),
            const SizedBox(height: 24),
            if (actionButton != null)
              actionButton
            else if (showBrowseButton)
              CustomButton(
                text: "Browse Services", // This button is more for clients
                onPressed: () {
                  // TODO: Navigate to services/explore screen
                  // Example: Provider.of<AppNavigationProvider>(context, listen: false).navigateTo(AppTab.explore);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Action: Browse services (Not implemented yet)")),
                  );
                },
                isPrimary: true,
                isFullWidth: false,
              ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // Ensure user data is loaded (e.g. if role changed elsewhere and screen rebuilds)
    // However, relying on initState and specific triggers for _loadUserData is safer.
    // For this iteration, we assume initState sets it up.
    // If _userService.currentUserRole can change and this screen is still active,
    // a mechanism to call _loadUserData and rebuild would be needed (e.g., via Provider/Riverpod).

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        centerTitle: true,
        title: Text(
          _userService.currentUserRole == UserRole.serviceAgent ? "Service Agent Profile" : "My Profile",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.done : Icons.edit, color: AppColors.primary),
            onPressed: () {
              if (_isEditing) {
                _saveChanges();
              } else {
                _toggleEditMode();
              }
            },
          ),
          if (_isEditing) // Show close button only in edit mode
            IconButton(
              icon: const Icon(Icons.close, color: AppColors.textMedium),
              onPressed: () {
                setState(() {
                  _isEditing = false;
                  // Optionally revert changes by reloading from _userService or initial _userData
                  _loadUserData(); // Revert changes by reloading
                });
              },
            )
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

  Widget _buildProfileHeader(BuildContext context) {
    bool isAgent = _userService.currentUserRole == UserRole.serviceAgent;
    // Use a placeholder if avatar URL is null or empty
    String avatarUrl = _userData['avatarUrl'] ?? 'assets/images/placeholder_avatar.png';
    if (avatarUrl.isEmpty) avatarUrl = 'assets/images/placeholder_avatar.png';


    return Padding( // Changed Container to Padding for better spacing control
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: AppColors.primaryLight.withOpacity(0.5),
                // backgroundImage: AssetImage(_userData["avatarUrl"]), // Use avatarUrl
                // Use NetworkImage if URL is from network, otherwise AssetImage
                // For mock data, ensure placeholder assets exist or handle errors.
                backgroundImage: _userData["avatarUrl"] != null && _userData["avatarUrl"].isNotEmpty
                               ? AssetImage(_userData["avatarUrl"])
                               : null, // Fallback to child icon if no image
                onBackgroundImageError: (exception, stackTrace) {
                  print("Error loading avatar: $exception");
                },
                child: (_userData["avatarUrl"] == null || _userData["avatarUrl"].isEmpty)
                    ? const Icon(Icons.person, size: 60, color: AppColors.primary)
                    : null,
              ),
              if (_isEditing)
                Positioned(
                  right: MediaQuery.of(context).size.width / 2 - 70, // Adjust positioning
                  bottom: 0,
                  child: Material( // Added Material for InkWell ripple effect
                    color: AppColors.primary,
                    shape: const CircleBorder(),
                    elevation: 2.0,
                    child: InkWell(
                      onTap: () { /* TODO: Implement image picker */ },
                      customBorder: const CircleBorder(),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          _isEditing
              ? CustomTextField(label: "Name", controller: _nameController, validator: (val) => val!.isEmpty ? "Name required" : null)
              : Text(
                  _userData["name"] ?? "N/A",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
          if (isAgent && (_isEditing || (_userData['businessName'] != null && _userData['businessName'].isNotEmpty)))
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: _isEditing
                  ? CustomTextField(label: "Business Name", controller: _businessNameController)
                  : Text(
                      _userData["businessName"] ?? "",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.primary),
                      textAlign: TextAlign.center,
                    ),
            ),
          const SizedBox(height: 8),
          _isEditing
              ? CustomTextField(label: "Bio", controller: _bioController, maxLines: 3)
              : Text(
                  _userData["bio"] ?? "No bio available.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textMedium),
                ),
          const SizedBox(height: 16),
          // Contact and Location Row (more responsive)
          Wrap( // Use Wrap for better responsiveness of info items
            spacing: 16.0, // Horizontal space between items
            runSpacing: 8.0, // Vertical space between lines
            alignment: WrapAlignment.center,
            children: [
              if (_isEditing || (_userData["phone"] != null && _userData["phone"].isNotEmpty))
                _buildInfoChip(
                  icon: Icons.phone_outlined,
                  text: _isEditing ? null : _userData["phone"] ?? "N/A",
                  controller: _isEditing ? _phoneController : null,
                  label: "Phone",
                  keyboardType: TextInputType.phone
                ),
              if (_isEditing || (_userData["location"] != null && _userData["location"].isNotEmpty))
                _buildInfoChip(
                  icon: Icons.location_on_outlined,
                  text: _isEditing ? null : _userData["location"] ?? "N/A",
                  controller: _isEditing ? _locationController : null,
                  label: "Location"
                ),
              if (!_isEditing && (_userData["memberSince"] != null && _userData["memberSince"].isNotEmpty))
                _buildInfoChip(
                  icon: Icons.calendar_today_outlined,
                  text: "Joined ${_userData["memberSince"]}",
                ),
               if (isAgent && (_userData['verified'] == true) && !_isEditing)
                 _buildInfoChip(
                    icon: Icons.verified_outlined,
                    text: "Verified Agent",
                    iconColor: Colors.green,
                  )
            ],
          ),
          // Removed the Save Changes button from here, it's now in AppBar actions
        ],
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    String? text,
    TextEditingController? controller,
    String? label,
    TextInputType? keyboardType,
    Color? iconColor,
  }) {
    if (_isEditing && controller != null) {
      return SizedBox(
        width: 180, // Give some width to editable fields
        child: CustomTextField(
          label: label ?? "",
          controller: controller,
          keyboardType: keyboardType ?? TextInputType.text,
          prefixIcon: Icon(icon, color: iconColor ?? AppColors.textLight, size: 18),
          isDense: true, // Smaller text field
        ),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min, // Important for Wrap
      children: [
        Icon(icon, size: 16, color: iconColor ?? AppColors.textLight),
        const SizedBox(width: 6),
        Flexible( // Allow text to wrap if it's too long
          child: Text(
            text ?? "",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textMedium),
            overflow: TextOverflow.ellipsis, // Add ellipsis for very long text
          ),
        ),
      ],
    );
  }


  Widget _buildProfileStats(BuildContext context) { // Added context
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

  Widget _buildJobHistoryTab() { // This is for Client "Order History"
    return _jobHistory.isEmpty
        ? _buildEmptyState(
            "No Order History",
            "You haven't completed any orders yet.",
            Icons.history_edu_outlined,
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _jobHistory.length,
            itemBuilder: (context, index) {
              final job = _jobHistory[index];
              return _buildJobHistoryCard(job); // Can reuse card if structure is similar
            },
          );
  }

  Widget _buildJobHistoryCard(Map<String, dynamic> job) { // This card is for client's past orders
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
    return _savedServices.isEmpty // This is for Client "Saved Items"
        ? _buildEmptyState(
            "No Saved Items",
            "You haven't saved any items yet.",
            Icons.bookmark_add_outlined,
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