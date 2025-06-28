// File: lib/services/user_service.dart
import 'package:shared_preferences/shared_preferences.dart';

// Enum to represent user roles
enum UserRole { client, serviceAgent, none }

class UserService {
  // Singleton instance
  static final UserService _instance = UserService._internal();

  factory UserService() {
    return _instance;
  }

  UserService._internal();

  // Current user role - defaults to none for proper auth flow
  UserRole _currentUserRole = UserRole.none;
  
  // Current user data
  Map<String, dynamic> _currentUserData = {};
  
  // Authentication state
  bool _isAuthenticated = false;

  // Getters
  UserRole get currentUserRole => _currentUserRole;
  Map<String, dynamic> get currentUserData => _currentUserData;
  bool get isAuthenticated => _isAuthenticated;

  // Method to set user role and data
  void setUserRole(UserRole role) {
    _currentUserRole = role;
    print("UserService: User role set to $role");
  }

  // Method to set user data from signup/login
  void setUserData(Map<String, dynamic> userData) {
    _currentUserData = Map.from(userData);
    _isAuthenticated = true;
    print("UserService: User data set: $userData");
  }

  // Method to create user data from signup form
  Map<String, dynamic> createUserData({
    required String fullName,
    required String email,
    required UserRole role,
    String? businessName,
    String? businessEmail,
    String? businessRegNumber,
    String? phone,
    String? location,
  }) {
    final Map<String, dynamic> userData = {
      "name": fullName,
      "email": email,
      "role": role == UserRole.serviceAgent ? "Service Agent" : "Client",
      "memberSince": _getCurrentMonthYear(),
      "avatarUrl": "", // Will be set later
    };

    if (role == UserRole.serviceAgent) {
      userData.addAll({
        "businessName": businessName ?? "",
        "businessEmail": businessEmail ?? email,
        "businessRegNumber": businessRegNumber ?? "",
        "verified": false,
        "servicesOffered": <String>[],
      });
    }

    // Add common fields if provided
    if (phone != null) userData["phone"] = phone;
    if (location != null) userData["location"] = location;

    // Set default bio based on role
    if (role == UserRole.serviceAgent) {
      userData["bio"] = "Professional service provider on BorgaTrust";
    } else {
      userData["bio"] = "Looking for great services on BorgaTrust";
    }

    return userData;
  }

  // Method to get current user data (either from stored data or mock)
  Map<String, dynamic> getUserData() {
    if (_isAuthenticated && _currentUserData.isNotEmpty) {
      return _currentUserData;
    }
    
    // Fallback to mock data if not authenticated
    return getMockUserData();
  }

  // Method to update user data (for profile editing)
  void updateUserData(Map<String, dynamic> updates) {
    _currentUserData.addAll(updates);
    print("UserService: User data updated: $updates");
  }

  // Method to simulate logging in with a specific role
  void login(String email, String password) {
    // Simulate authentication
    if (email.contains("agent")) {
      _currentUserRole = UserRole.serviceAgent;
    } else {
      _currentUserRole = UserRole.client;
    }
    
    // Create user data from login
    final userData = createUserData(
      fullName: email.contains("agent") ? "Service Agent Pro" : "Client User",
      email: email,
      role: _currentUserRole,
      phone: email.contains("agent") ? "+233 55 333 4444" : "+233 20 111 2222",
      location: email.contains("agent") ? "Kumasi, Ghana" : "Accra, Ghana",
      businessName: email.contains("agent") ? "Pro Services Ltd." : null,
    );
    
    setUserData(userData);
    _saveAuthState();
  }

  // Method to signup user
  void signup(Map<String, dynamic> signupData) {
    final role = signupData['role'] == 'service_agent' ? UserRole.serviceAgent : UserRole.client;
    _currentUserRole = role;
    
    final userData = createUserData(
      fullName: signupData['fullName'],
      email: signupData['email'],
      role: role,
      businessName: signupData['businessName'],
      businessEmail: signupData['businessEmail'],
      businessRegNumber: signupData['businessRegNumber'],
      phone: signupData['phone'],
      location: signupData['location'],
    );
    
    setUserData(userData);
    _saveAuthState();
  }

  // Method to toggle role for testing purposes
  void toggleUserRole() {
    if (_currentUserRole == UserRole.client) {
      _currentUserRole = UserRole.serviceAgent;
    } else {
      _currentUserRole = UserRole.client;
    }
    print("UserService: User role toggled to $_currentUserRole");
  }

  // Simulate user logout
  void logout() {
    _currentUserRole = UserRole.none;
    _currentUserData.clear();
    _isAuthenticated = false;
    _clearAuthState();
    print("UserService: User logged out");
  }

  // Save authentication state to SharedPreferences
  Future<void> _saveAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_authenticated', _isAuthenticated);
    await prefs.setString('user_role', _currentUserRole.name);
    // Note: In a real app, you'd want to encrypt sensitive data
    // For now, we'll store basic info
    await prefs.setString('user_email', _currentUserData['email'] ?? '');
    await prefs.setString('user_name', _currentUserData['name'] ?? '');
  }

  // Load authentication state from SharedPreferences
  Future<void> loadAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    _isAuthenticated = prefs.getBool('is_authenticated') ?? false;
    
    if (_isAuthenticated) {
      final roleString = prefs.getString('user_role') ?? 'none';
      _currentUserRole = UserRole.values.firstWhere(
        (role) => role.name == roleString,
        orElse: () => UserRole.none,
      );
      
      // Reconstruct basic user data
      _currentUserData = {
        "name": prefs.getString('user_name') ?? '',
        "email": prefs.getString('user_email') ?? '',
        "role": _currentUserRole == UserRole.serviceAgent ? "Service Agent" : "Client",
      };
    }
  }

  // Clear authentication state
  Future<void> _clearAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('is_authenticated');
    await prefs.remove('user_role');
    await prefs.remove('user_email');
    await prefs.remove('user_name');
  }

  // Helper method to get current month and year
  String _getCurrentMonthYear() {
    final now = DateTime.now();
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return "${months[now.month - 1]} ${now.year}";
  }

  // Example user data - this would typically come from your auth/backend
  // For now, we can use it to provide some basic info.
  Map<String, dynamic> getMockUserData() {
    if (_currentUserRole == UserRole.client) {
      return {
        "name": "Client User",
        "email": "client@example.com",
        "phone": "+233 20 111 2222",
        "location": "Accra, Ghana",
        "bio": "I am a client looking for great services!",
        "memberSince": "October 2023",
        "avatarUrl": "assets/images/client_avatar_placeholder.png",
        "role": "Client"
      };
    } else if (_currentUserRole == UserRole.serviceAgent) {
      return {
        "name": "Service Agent Pro",
        "email": "agent@example.com",
        "businessName": "Pro Services Ltd.",
        "phone": "+233 55 333 4444",
        "location": "Kumasi, Ghana",
        "bio": "Offering top-notch web development and design services.",
        "memberSince": "January 2023",
        "avatarUrl": "assets/images/agent_avatar_placeholder.png",
        "role": "Service Agent",
        "verified": true,
        "servicesOffered": ["Web Development", "Graphic Design"]
      };
    }
    return {
       "name": "Guest User",
       "email": "guest@example.com",
       "role": "None"
    };
  }
}
