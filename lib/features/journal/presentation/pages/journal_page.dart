import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/wellness_colors.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../shared/widgets/wellness_card.dart';
import '../../../../shared/widgets/encouragement_banner.dart';
import '../../../nutrition/domain/entities/food.dart';

class JournalPage extends ConsumerStatefulWidget {
  const JournalPage({super.key});

  @override
  ConsumerState<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends ConsumerState<JournalPage>
    with TickerProviderStateMixin {
  late AnimationController _moodController;
  late Animation<double> _moodAnimation;
  
  DateTime _selectedDate = DateTime.now();
  WellnessMoodType _currentMood = WellnessMoodType.good;
  
  // Simulation de données de journal
  final List<JournalEntry> _todayEntries = [
    JournalEntry(
      id: '1',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      mealType: MealType.breakfast,
      foods: [
        Food(
          id: '1',
          name: 'Flocons d\'avoine',
          category: 'Céréales',
        ),
        Food(
          id: '2',
          name: 'Banane',
          category: 'Fruits',
        ),
      ],
      mood: WellnessMoodType.good,
      mindfulnessScore: 0.8,
      notes: 'Un petit-déjeuner nourrissant pour bien commencer la journée !',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _moodController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _moodAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _moodController,
      curve: Curves.easeOut,
    ));
    
    _moodController.forward();
  }

  @override
  void dispose() {
    _moodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WellnessColors.backgroundCream,
      appBar: AppBar(
        title: const Text('Votre voyage nutritionnel 🌱'),
        backgroundColor: WellnessColors.primaryBlue,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _showCalendarPicker,
            icon: const Icon(Icons.calendar_today),
            tooltip: 'Changer de date',
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Header avec date et humeur
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    WellnessColors.primaryBlue,
                    WellnessColors.backgroundCream,
                  ],
                  stops: const [0.0, 0.3],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildDateHeader(),
                    const SizedBox(height: 16),
                    _buildMoodCheckIn(),
                  ],
                ),
              ),
            ),
          ),
          
          // Contenu principal
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Prompt mindfulness si aucune entrée
                if (_todayEntries.isEmpty) 
                  const MindfulnessPrompt(),
                
                const SizedBox(height: 16),
                
                // Timeline des repas
                _buildMealsTimeline(),
                
                const SizedBox(height: 24),
                
                // Insights de la journée
                _buildDayInsights(),
                
                const SizedBox(height: 100), // Espace pour navigation
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: HeartbeatAnimation(
        child: FloatingActionButton.extended(
          onPressed: _showAddMealDialog,
          icon: const Icon(Icons.add_circle_outline),
          label: const Text('Ajouter'),
          backgroundColor: WellnessColors.secondaryGreen,
        ),
      ),
    );
  }

  Widget _buildDateHeader() {
    final isToday = _isSameDay(_selectedDate, DateTime.now());
    
    return WellnessCard(
      backgroundColor: Colors.white.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: WellnessColors.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                isToday ? Icons.today : Icons.calendar_today,
                color: WellnessColors.primaryBlue,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isToday ? 'Aujourd\'hui' : _formatDate(_selectedDate),
                    style: WellnessTextStyles.heading3,
                  ),
                  Text(
                    _formatDateSubtitle(_selectedDate),
                    style: WellnessTextStyles.bodyTextSmall,
                  ),
                ],
              ),
            ),
            if (isToday)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: WellnessColors.successGentle,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Actuel',
                  style: WellnessTextStyles.captionText.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodCheckIn() {
    return WellnessCard(
      backgroundColor: Colors.white.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Comment vous sentez-vous ? 😊',
              style: WellnessTextStyles.labelLarge,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: WellnessMoodType.values.map((mood) {
                final isSelected = _currentMood == mood;
                return GestureDetector(
                  onTap: () => _updateMood(mood),
                  child: AnimatedScale(
                    scale: isSelected ? 1.1 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? WellnessColors.primaryBlue.withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            mood.emoji,
                            style: TextStyle(fontSize: 28),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            mood.label,
                            style: WellnessTextStyles.captionText.copyWith(
                              color: isSelected 
                                  ? WellnessColors.primaryBlue 
                                  : WellnessColors.textSecondary,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealsTimeline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vos repas aujourd\'hui 🍽️',
          style: WellnessTextStyles.heading3,
        ),
        const SizedBox(height: 16),
        
        if (_todayEntries.isEmpty)
          _buildEmptyState()
        else
          ..._todayEntries.map((entry) => _buildMealEntry(entry)).toList(),
          
        const SizedBox(height: 16),
        _buildMealSuggestions(),
      ],
    );
  }

  Widget _buildEmptyState() {
    return WellnessCard(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              Icons.restaurant_menu,
              size: 48,
              color: WellnessColors.textSecondary.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Votre première entrée vous attend ! ✨',
              style: WellnessTextStyles.heading3.copyWith(
                color: WellnessColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Commencez votre voyage nutritionnel en ajoutant votre premier repas. '
              'Chaque pas compte !',
              style: WellnessTextStyles.bodyText.copyWith(
                color: WellnessColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            WellnessButton(
              onPressed: _showAddMealDialog,
              child: const Text('Ajouter mon premier repas'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealEntry(JournalEntry entry) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: WellnessCard(
        onTap: () => _showMealDetails(entry),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getMealTypeColor(entry.mealType).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getMealTypeIcon(entry.mealType),
                      color: _getMealTypeColor(entry.mealType),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getMealTypeName(entry.mealType),
                          style: WellnessTextStyles.labelLarge,
                        ),
                        Text(
                          _formatTime(entry.timestamp),
                          style: WellnessTextStyles.bodyTextSmall,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    entry.mood.emoji,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: entry.foods.map((food) => Chip(
                  label: Text(food.name),
                  backgroundColor: WellnessColors.accentSoft,
                  labelStyle: WellnessTextStyles.bodyTextSmall,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                )).toList(),
              ),
              if (entry.notes != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: WellnessColors.neutralWarm,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.format_quote,
                        color: WellnessColors.textSecondary,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          entry.notes!,
                          style: WellnessTextStyles.bodyTextSmall.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMealSuggestions() {
    return WellnessCard(
      backgroundColor: WellnessColors.accentSoft,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: WellnessColors.primaryBlue,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Suggestions bienveillantes',
                  style: WellnessTextStyles.labelLarge.copyWith(
                    color: WellnessColors.primaryBlue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Et si vous ajoutiez une touche de couleur à votre prochaine collation ? '
              'Une pomme croquante ou quelques noix pourraient faire du bien ! 🍎✨',
              style: WellnessTextStyles.bodyTextSmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayInsights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Insights de votre journée 📊',
          style: WellnessTextStyles.heading3,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildInsightCard(
                '🌈',
                'Diversité',
                '3 couleurs',
                'Beau travail !',
                WellnessColors.secondaryGreen,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildInsightCard(
                '🧘‍♀️',
                'Mindfulness',
                '80%',
                'Très présent(e)',
                WellnessColors.warningWarm,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInsightCard(
    String emoji,
    String title,
    String value,
    String subtitle,
    Color color,
  ) {
    return WellnessCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              emoji,
              style: TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: WellnessTextStyles.heading2.copyWith(color: color),
            ),
            Text(
              title,
              style: WellnessTextStyles.labelLarge,
            ),
            Text(
              subtitle,
              style: WellnessTextStyles.bodyTextSmall.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }

  String _formatDate(DateTime date) {
    final months = [
      '', 'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
      'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'
    ];
    return '${date.day} ${months[date.month]}';
  }

  String _formatDateSubtitle(DateTime date) {
    final weekdays = [
      '', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'
    ];
    return weekdays[date.weekday];
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  Color _getMealTypeColor(MealType type) {
    switch (type) {
      case MealType.breakfast:
        return WellnessColors.warningWarm;
      case MealType.lunch:
        return WellnessColors.secondaryGreen;
      case MealType.dinner:
        return WellnessColors.primaryBlue;
      case MealType.snack:
        return WellnessColors.successGentle;
    }
  }

  IconData _getMealTypeIcon(MealType type) {
    switch (type) {
      case MealType.breakfast:
        return Icons.wb_sunny;
      case MealType.lunch:
        return Icons.restaurant;
      case MealType.dinner:
        return Icons.dinner_dining;
      case MealType.snack:
        return Icons.cookie;
    }
  }

  String _getMealTypeName(MealType type) {
    switch (type) {
      case MealType.breakfast:
        return 'Petit-déjeuner';
      case MealType.lunch:
        return 'Déjeuner';
      case MealType.dinner:
        return 'Dîner';
      case MealType.snack:
        return 'Collation';
    }
  }

  // Actions
  void _updateMood(WellnessMoodType mood) {
    setState(() {
      _currentMood = mood;
    });
    
    final messages = {
      WellnessMoodType.excellent: '✨ Magnifique ! Votre énergie rayonne',
      WellnessMoodType.good: '💚 Super ! Vous prenez soin de vous',
      WellnessMoodType.neutral: '🌿 C\'est parfait d\'être à l\'écoute',
      WellnessMoodType.challenging: '🤗 Merci de votre authenticité',
    };
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(messages[mood]!),
        backgroundColor: WellnessColors.successGentle,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showCalendarPicker() {
    showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 7)),
    ).then((date) {
      if (date != null) {
        setState(() {
          _selectedDate = date;
        });
      }
    });
  }

  void _showAddMealDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddMealBottomSheet(),
    );
  }

  void _showMealDetails(JournalEntry entry) {
    // Navigation vers détails du repas
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('📖 Ouverture des détails du ${_getMealTypeName(entry.mealType).toLowerCase()}...'),
        backgroundColor: WellnessColors.primaryBlue,
      ),
    );
  }
}

// Enums et classes de données
enum WellnessMoodType {
  excellent('Excellent', '✨'),
  good('Bien', '😊'),
  neutral('Neutre', '😐'),
  challenging('Difficile', '🤗');

  const WellnessMoodType(this.label, this.emoji);
  final String label;
  final String emoji;
}

enum MealType {
  breakfast,
  lunch,
  dinner,
  snack,
}

class JournalEntry {
  final String id;
  final DateTime timestamp;
  final MealType mealType;
  final List<Food> foods;
  final WellnessMoodType mood;
  final double mindfulnessScore;
  final String? notes;

  const JournalEntry({
    required this.id,
    required this.timestamp,
    required this.mealType,
    required this.foods,
    required this.mood,
    required this.mindfulnessScore,
    this.notes,
  });
}

class AddMealBottomSheet extends StatelessWidget {
  const AddMealBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  'Ajouter un repas 🍽️',
                  style: WellnessTextStyles.heading3,
                ),
                const SizedBox(height: 8),
                Text(
                  'Partagez votre expérience alimentaire avec bienveillance',
                  style: WellnessTextStyles.bodyTextSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                WellnessButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('🌟 Fonctionnalité en cours de développement !'),
                        backgroundColor: WellnessColors.primaryBlue,
                      ),
                    );
                  },
                  child: const Text('Continuer'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
