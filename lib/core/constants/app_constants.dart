class AppConstants {
  // App Information
  static const String appName = 'Wellness Nutrition';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String openFoodFactsBaseUrl = 'https://world.openfoodfacts.org/api/v2/product/';
  static const int requestTimeoutSeconds = 30;
  
  // Cache Configuration
  static const int cacheMaxAgeHours = 24;
  static const String nutritionCacheBox = 'nutrition_cache';
  static const String userPreferencesBox = 'user_preferences';
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 12.0;
  static const double defaultIconSize = 24.0;
  
  // Animation Durations
  static const int defaultAnimationDurationMs = 300;
  static const int feedbackAnimationDurationMs = 800;
  
  // Wellness Messages
  static const List<String> encouragementMessages = [
    '🌟 Magnifique ! Vous prenez soin de votre bien-être',
    '💚 Bravo ! Chaque geste bienveillant compte',
    '✨ Super ! Vous écoutez votre corps avec sagesse',
    '🌱 Merveilleux ! Votre parcours nutritionnel évolue positivement',
    '🎨 Excellent ! Vous ajoutez de la couleur à votre alimentation',
  ];
  
  static const List<String> mindfulnessPrompts = [
    '🧘‍♀️ Prenez trois respirations profondes avant de commencer',
    '💭 Comment vous sentez-vous en ce moment ?',
    '🌸 Accordez-vous un moment de bienveillance',
    '🤗 Vous méritez tout l\'amour que vous vous portez',
    '🌈 Chaque couleur dans votre assiette raconte une histoire',
  ];
  
  // Feature Flags
  static const bool enableMindfulnessMode = true;
  static const bool enableOfflineMode = true;
  static const bool enableVibrationFeedback = true;
  
  // Cultural Adaptations
  static const Map<String, String> culturalGreetings = {
    'fr': '🌅 Bonjour ! Prêt(e) pour une journée bienveillante ?',
    'en': '🌅 Good morning! Ready for a mindful day?',
    'es': '🌅 ¡Buenos días! ¿Preparado para un día consciente?',
    'de': '🌅 Guten Morgen! Bereit für einen achtsamen Tag?',
  };
}
