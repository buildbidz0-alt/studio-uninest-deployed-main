class AppConstants {
  static const String appName = 'UniNest';
  static const String appTagline = 'Your all-in-one digital campus hub';
  
  // Stats
  static const int studentsCount = 10000;
  static const int vendorsCount = 200;
  static const int librariesCount = 50;
  
  // Pagination
  static const int pageSize = 20;
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  
  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration cacheTimeout = Duration(hours: 24);
  
  // Support
  static const String supportEmail = 'support@uninest.com';
  static const String termsUrl = 'https://uninest.com/terms';
  static const String privacyUrl = 'https://uninest.com/privacy';
}

class AssetPaths {
  static const String images = 'assets/images/';
  static const String icons = 'assets/icons/';
  static const String animations = 'assets/animations/';
  
  static const String appIcon = '${icons}app_icon.png';
  static const String placeholder = '${images}placeholder.png';
}

class RouteNames {
  static const String home = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String social = '/social';
  static const String marketplace = '/marketplace';
  static const String notes = '/notes';
  static const String workspace = '/workspace';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String chat = '/chat';
  static const String aiChat = '/ai-chat';
  static const String admin = '/admin';
  static const String donate = '/donate';
  static const String support = '/support';
}
