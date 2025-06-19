import 'package:flutter/material.dart';

class WellnessColors {
  // Couleurs Primaires Apaisantes
  static const Color primaryBlue = Color(0xFF4A90E2);     // Bleu apaisant
  static const Color secondaryGreen = Color(0xFF68B684);   // Vert nature
  static const Color accentSoft = Color(0xFFE8F4FD);      // Bleu très clair
  
  // Neutres Chaleureux
  static const Color neutralWarm = Color(0xFFF8F9FA);     // Gris très clair
  static const Color backgroundCream = Color(0xFFFAFAFA);  // Blanc cassé
  static const Color textPrimary = Color(0xFF2C3E50);     // Bleu foncé doux
  static const Color textSecondary = Color(0xFF7F8C8D);   // Gris doux
  
  // Couleurs d'État Douces
  static const Color successGentle = Color(0xFF8FBC8F);   // Vert sauge
  static const Color warningWarm = Color(0xFFDDB15F);     // Jaune miel
  static const Color errorSoft = Color(0xFFE8A598);       // Rose poudré
  static const Color infoBlue = Color(0xFF85C1E9);        // Bleu ciel
  
  // Couleurs d'accentuation pour la diversité alimentaire
  static const Color vegetableGreen = Color(0xFF27AE60);  // Vert légumes
  static const Color fruitOrange = Color(0xFFF39C12);     // Orange fruits
  static const Color grainBrown = Color(0xFFD4AC0D);      // Brun céréales
  static const Color proteinRed = Color(0xFFE74C3C);      // Rouge protéines
  static const Color dairyBlue = Color(0xFF3498DB);       // Bleu laitier
  
  // Gradients apaisants
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryBlue, secondaryGreen],
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [accentSoft, backgroundCream],
  );
  
  static const LinearGradient sunsetGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFE082), Color(0xFFFFAB40)],
  );
  
  // Palettes pour états émotionnels
  static const Map<String, Color> moodColors = {
    'excellent': Color(0xFF52C41A),    // Vert vibrant
    'good': secondaryGreen,            // Vert nature
    'neutral': Color(0xFFFAAD14),      // Jaune doux
    'challenging': warningWarm,        // Orange chaleureux
  };
  
  // Couleurs pour catégories nutritionnelles
  static const Map<String, Color> nutritionCategoryColors = {
    'vegetables': vegetableGreen,
    'fruits': fruitOrange,
    'grains': grainBrown,
    'proteins': proteinRed,
    'dairy': dairyBlue,
    'oils': Color(0xFFF1C40F),
    'beverages': Color(0xFF16A085),
    'snacks': Color(0xFF9B59B6),
  };
  
  // Accessibilité et contraste
  static const double minimumContrastRatio = 4.5;
  
  // Couleurs à éviter (anti-patterns)
  // ❌ Rouge vif agressif
  // ❌ Orange criard
  // ❌ Noir dominant
  // ❌ Couleurs flashy ou stressantes
}
