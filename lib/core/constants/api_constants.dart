class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://us-central1-colis-app-72dfa.cloudfunctions.net';
  static const String apiPrefix = '/api';

  // Endpoints
  static const String restaurants = '$apiPrefix/restaurants';
  static const String restaurantLocations = '$apiPrefix/restaurant-locations';
  static const String restaurantSocials = '$apiPrefix/restaurant-socials';
  static const String directoryCategories = '$apiPrefix/directory-categories';
  static const String directoryProfiles = '$apiPrefix/directory-profiles';
  static const String profileContacts = '$apiPrefix/profile-contacts';
  static const String profileLocations = '$apiPrefix/profile-locations';
  static const String profileSocials = '$apiPrefix/profile-socials';
  static const String menus = '$apiPrefix/menus';
  static const String menuCategories = '$apiPrefix/menu-categories';
  static const String menuItems = '$apiPrefix/menu-items';
  static const String config = '$apiPrefix/config';
  static const String health = '$apiPrefix/health';
  static const String orders = '$apiPrefix/orders';
  static const String deviceTokens = '$apiPrefix/device-tokens';
  static const String planRequests = '$apiPrefix/plan-requests';
}
