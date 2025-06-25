// File: lib/services/user_service.dart

// Enum to represent user roles
enum UserRole { client, serviceAgent, none }

class UserService {
  // Singleton instance
  static final UserService _instance = UserService._internal();

  factory UserService() {
    return _instance;
  }

  UserService._internal();

  // Current user role - defaults to client for initial testing
  UserRole _currentUserRole = UserRole.client;

  // Getter for the current user role
  UserRole get currentUserRole => _currentUserRole;

  // Method to simulate logging in with a specific role
  void setUserRole(UserRole role) {
    _currentUserRole = role;
    // In a real app, you would notify listeners here if using a state management solution
    print("UserService: User role set to $role");
  }

  // Method to toggle role for testing purposes
  void toggleUserRole() {
    if (_currentUserRole == UserRole.client) {
      _currentUserRole = UserRole.serviceAgent;
    } else {
      _currentUserRole = UserRole.client;
    }
    print("UserService: User role toggled to $_currentUserRole");
    // In a real app, notify listeners
  }

  // Simulate user logout
  void logout() {
    _currentUserRole = UserRole.none;
     print("UserService: User logged out, role set to none");
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
        "avatarUrl": "assets/images/client_avatar_placeholder.png", // Add a placeholder asset
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
        "avatarUrl": "assets/images/agent_avatar_placeholder.png", // Add a placeholder asset
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
