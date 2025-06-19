import 'package:freezed_annotation/freezed_annotation.dart';

part 'wellness.freezed.dart';
part 'wellness.g.dart';

@freezed
class WellnessMetrics with _$WellnessMetrics {
  const factory WellnessMetrics({
    required WellnessMood currentMood,
    @Default([]) List<Food> newFoodsExplored,
    @Default(0.0) double culturalDiversity, // 0.0 à 1.0
    @Default(0) int mindfulMeals,
    @Default(0.0) double averagePresenceScore, // Qualité > quantité
    @Default([]) List<GentleAchievement> gentleAchievements,
    @Default('') String personalizedEncouragement,
    @Default(false) bool isReflectionMode,
    DateTime? lastUpdated,
  }) = _WellnessMetrics;

  factory WellnessMetrics.fromJson(Map<String, dynamic> json) => 
      _$WellnessMetricsFromJson(json);
}

@freezed
class WellnessMood with _$WellnessMood {
  const factory WellnessMood({
    required MoodType type,
    required DateTime timestamp,
    String? note,
    @Default(0.0) double energyLevel, // 0.0 à 1.0
    @Default(0.0) double satisfactionLevel, // 0.0 à 1.0
  }) = _WellnessMood;

  factory WellnessMood.fromJson(Map<String, dynamic> json) => 
      _$WellnessMoodFromJson(json);
}

enum MoodType {
  excellent('Excellent', '✨', '#52C41A'),
  good('Bien', '😊', '#68B684'),
  neutral('Neutre', '😐', '#FAAD14'),
  challenging('Difficile', '🤗', '#DDB15F');

  const MoodType(this.label, this.emoji, this.color);

  final String label;
  final String emoji;
  final String color;
}

@freezed
class GentleAchievement with _$GentleAchievement {
  const factory GentleAchievement({
    required String id,
    required String title,
    required String description,
    required String emoji,
    required DateTime unlockedAt,
    @Default(AchievementType.exploration) AchievementType type,
    Map<String, dynamic>? metadata,
  }) = _GentleAchievement;

  factory GentleAchievement.fromJson(Map<String, dynamic> json) => 
      _$GentleAchievementFromJson(json);
}

enum AchievementType {
  exploration('Exploration', '🔍'),
  mindfulness('Pleine Conscience', '🧘‍♀️'),
  diversity('Diversité', '🌈'),
  consistency('Régularité', '🌱'),
  selfCare('Bienveillance', '💚'),
  learning('Apprentissage', '📚');

  const AchievementType(this.label, this.emoji);

  final String label;
  final String emoji;
}

@freezed
class MindfulMoment with _$MindfulMoment {
  const factory MindfulMoment({
    required String id,
    required DateTime timestamp,
    required MindfulnessType type,
    @Default(0.0) double duration, // en minutes
    @Default(0.0) double presenceScore, // 0.0 à 1.0
    String? reflection,
    @Default([]) List<String> emotions,
    @Default([]) List<String> bodySignals,
  }) = _MindfulMoment;

  factory MindfulMoment.fromJson(Map<String, dynamic> json) => 
      _$MindfulMomentFromJson(json);
}

enum MindfulnessType {
  preMeal('Avant repas', '🙏'),
  duringMeal('Pendant repas', '🧘‍♀️'),
  postMeal('Après repas', '💭'),
  gratitude('Gratitude', '🌟'),
  bodyAwareness('Conscience corporelle', '🤲');

  const MindfulnessType(this.label, this.emoji);

  final String label;
  final String emoji;
}

// Achievements prédéfinis bienveillants
class WellnessAchievements {
  static const List<GentleAchievement> predefinedAchievements = [
    GentleAchievement(
      id: 'first_scan',
      title: 'Premier scan',
      description: 'Vous avez découvert votre premier produit ! 🎉',
      emoji: '📱',
      unlockedAt: null,
      type: AchievementType.exploration,
    ),
    GentleAchievement(
      id: 'mindful_meal',
      title: 'Repas conscient',
      description: 'Vous avez pris le temps de savourer mindfulness',
      emoji: '🧘‍♀️',
      unlockedAt: null,
      type: AchievementType.mindfulness,
    ),
    GentleAchievement(
      id: 'color_explorer',
      title: 'Explorateur de couleurs',
      description: 'Vous avez ajouté 5 couleurs différentes à vos repas',
      emoji: '🌈',
      unlockedAt: null,
      type: AchievementType.diversity,
    ),
    GentleAchievement(
      id: 'week_consistency',
      title: 'Une semaine bienveillante',
      description: 'Vous prenez soin de vous depuis 7 jours',
      emoji: '🌱',
      unlockedAt: null,
      type: AchievementType.consistency,
    ),
    GentleAchievement(
      id: 'self_compassion',
      title: 'Auto-compassion',
      description: 'Vous vous êtes montré(e) bienveillant(e) avec vous-même',
      emoji: '💚',
      unlockedAt: null,
      type: AchievementType.selfCare,
    ),
  ];

  static GentleAchievement? getAchievementById(String id) {
    try {
      return predefinedAchievements.firstWhere(
        (achievement) => achievement.id == id,
      );
    } catch (e) {
      return null;
    }
  }
}

import '../nutrition/domain/entities/food.dart';
