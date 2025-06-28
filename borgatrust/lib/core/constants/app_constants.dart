// File: lib/core/constants/app_constants.dart

class AppConstants {
  // App Information
  static const String appName = 'BorgaTrust';
  static const String appVersion = '1.1.0';
  static const String appDescription = 'Connect the diaspora with trusted service makers';
  
  // API Configuration
  static const String baseUrl = 'https://api.borgatrust.com'; // Replace with actual API
  static const int apiTimeout = 30000; // 30 seconds
  static const int maxRetries = 3;
  
  // Cache Configuration
  static const Duration imageCacheDuration = Duration(days: 7);
  static const Duration dataCacheDuration = Duration(hours: 1);
  static const int maxCacheSize = 100 * 1024 * 1024; // 100MB
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int maxNameLength = 100;
  static const int maxDescriptionLength = 1000;
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 12.0;
  static const double defaultElevation = 2.0;
  
  // Animation Durations
  static const Duration fastAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);
  
  // Background Task IDs
  static const String syncDataTaskId = 'sync_data_task';
  static const String cacheCleanupTaskId = 'cache_cleanup_task';
  
  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String userDataKey = 'user_data';
  static const String onboardingCompletedKey = 'onboarding_completed';
  static const String themeModeKey = 'theme_mode';
  static const String languageKey = 'language';
}

class AssetPaths {
  static const String logo = 'assets/images/borgatrust_logo.png';
  static const String onboardingAi = 'assets/images/onboarding_ai.png';
  static const String onboardingBlockchain = 'assets/images/onboarding_blockchain.png';
  static const String onboardingMission = 'assets/images/onboarding_mission.png';
  static const String googleLogo = 'assets/images/google_logo.png';
  
  // Featured service images
  static const String featuredWebDev = 'assets/images/featured_web_dev.jpg';
  static const String featuredLogoDesign = 'assets/images/featured_logo_design.jpg';
  static const String featuredContentWriting = 'assets/images/featured_content_writing.jpg';
  static const String featuredEvents = 'assets/images/featured_events.jpg';
  static const String featuredTranslation = 'assets/images/featured_translation.jpg';
  static const String featuredLegal = 'assets/images/featured_legal.jpg';
  
  // Provider images
  static const String providerWebDev = 'assets/images/provider_web_dev.jpg';
  static const String providerGraphicDesign = 'assets/images/provider_graphic_design.jpg';
  static const String providerContentWriting = 'assets/images/provider_content_writing.jpg';
} 