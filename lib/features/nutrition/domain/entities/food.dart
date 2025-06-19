import 'package:freezed_annotation/freezed_annotation.dart';

part 'food.freezed.dart';
part 'food.g.dart';

@freezed
class Food with _$Food {
  const factory Food({
    required String id,
    required String name,
    String? brand,
    String? category,
    String? imageUrl,
    @Default([]) List<String> ingredients,
    NutritionFacts? nutritionFacts,
    @Default([]) List<String> allergens,
    String? origin,
    @Default(0.0) double ecoScore,
    @Default(0.0) double novaScore,
    @Default(0.0) double nutritionGrade,
    DateTime? lastUpdated,
  }) = _Food;

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);
}

@freezed
class NutritionFacts with _$NutritionFacts {
  const factory NutritionFacts({
    @Default(0.0) double energyKcal,
    @Default(0.0) double proteins,
    @Default(0.0) double carbohydrates,
    @Default(0.0) double fat,
    @Default(0.0) double fiber,
    @Default(0.0) double sugar,
    @Default(0.0) double sodium,
    @Default(0.0) double saturatedFat,
    Map<String, double>? vitamins,
    Map<String, double>? minerals,
  }) = _NutritionFacts;

  factory NutritionFacts.fromJson(Map<String, dynamic> json) => 
      _$NutritionFactsFromJson(json);
}

@freezed
class FoodCategory with _$FoodCategory {
  const factory FoodCategory({
    required String id,
    required String name,
    required String emoji,
    required String color,
    String? description,
    @Default([]) List<String> subcategories,
  }) = _FoodCategory;

  factory FoodCategory.fromJson(Map<String, dynamic> json) => 
      _$FoodCategoryFromJson(json);
}

// Catégories prédéfinies bienveillantes
class WellnessFoodCategories {
  static const List<FoodCategory> categories = [
    FoodCategory(
      id: 'vegetables',
      name: 'Légumes',
      emoji: '🥬',
      color: '#27AE60',
      description: 'Légumes frais, colorés et nutritifs',
    ),
    FoodCategory(
      id: 'fruits',
      name: 'Fruits',
      emoji: '🍎',
      color: '#F39C12',
      description: 'Fruits de saison, sources de vitamines',
    ),
    FoodCategory(
      id: 'grains',
      name: 'Céréales',
      emoji: '🌾',
      color: '#D4AC0D',
      description: 'Céréales complètes et énergétiques',
    ),
    FoodCategory(
      id: 'proteins',
      name: 'Protéines',
      emoji: '🥩',
      color: '#E74C3C',
      description: 'Sources de protéines variées',
    ),
    FoodCategory(
      id: 'dairy',
      name: 'Produits laitiers',
      emoji: '🥛',
      color: '#3498DB',
      description: 'Laitages et alternatives végétales',
    ),
    FoodCategory(
      id: 'beverages',
      name: 'Boissons',
      emoji: '🥤',
      color: '#16A085',
      description: 'Hydratation et plaisir',
    ),
    FoodCategory(
      id: 'snacks',
      name: 'Collations',
      emoji: '🍪',
      color: '#9B59B6',
      description: 'Petits plaisirs et encas',
    ),
  ];

  static FoodCategory? getCategoryByName(String name) {
    try {
      return categories.firstWhere(
        (category) => category.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  static FoodCategory getDefaultCategory() {
    return const FoodCategory(
      id: 'other',
      name: 'Autre',
      emoji: '🍽️',
      color: '#95A5A6',
      description: 'Autres aliments',
    );
  }
}
