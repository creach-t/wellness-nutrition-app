import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/wellness_colors.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../shared/widgets/wellness_card.dart';
import '../../../../shared/widgets/encouragement_banner.dart';
import '../../../wellness/domain/entities/wellness.dart';

class WellnessDashboardPage extends ConsumerWidget {
  const WellnessDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: WellnessColors.backgroundCream,
      appBar: AppBar(
        title: const Text('Votre parcours bien-être 🌱'),
        backgroundColor: WellnessColors.primaryBlue,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _showWellnessSettings(context),
            icon: const Icon(Icons.settings),
            tooltip: 'Paramètres bien-être',
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Header gradient
          SliverToBoxAdapter(
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    WellnessColors.primaryBlue,
                    WellnessColors.backgroundCream,
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
                // Check-in émotionnel
                _buildWellnessOverview(),
                
                const SizedBox(height: 24),
                
                // Métriques de bien-être
                _buildWellnessMetrics(),
                
                const SizedBox(height: 24),
                
                // Découvertes alimentaires
                _buildFoodDiscoveries(),
                
                const SizedBox(height: 24),
                
                // Moments mindful
                _buildMindfulMoments(),
                
                const SizedBox(height: 24),
                
                // Achievements bienveillants
                _buildGentleAchievements(),
                
                const SizedBox(height: 24),
                
                // Message d'encouragement personnalisé
                _buildPersonalizedEncouragement(),
                
                const SizedBox(height: 100), // Espace pour navigation
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWellnessOverview() {
    return WellnessCard(
      gradient: WellnessColors.backgroundGradient,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: WellnessColors.primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.favorite,
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
                        'Comment vous sentez-vous ?',
                        style: WellnessTextStyles.heading3,
                      ),
                      Text(
                        'Votre ressenti est plus important que tout chiffre',
                        style: WellnessTextStyles.bodyTextSmall.copyWith(
                          color: WellnessColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMoodOption(MoodType.excellent),
                _buildMoodOption(MoodType.good),
                _buildMoodOption(MoodType.neutral),
                _buildMoodOption(MoodType.challenging),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodOption(MoodType mood) {
    final isSelected = mood == MoodType.good; // Simulation
    
    return GestureDetector(
      onTap: () => {}, // Action de mise à jour d'humeur
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? WellnessColors.primaryBlue.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(color: WellnessColors.primaryBlue, width: 2)
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              mood.emoji,
              style: TextStyle(fontSize: 24),
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
    );
  }

  Widget _buildWellnessMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Votre progression cette semaine 📊',
          style: WellnessTextStyles.heading3,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                '🌈',
                'Diversité',
                '7',
                'nouveaux aliments',
                WellnessColors.secondaryGreen,
                0.7,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                '🧘‍♀️',
                'Mindfulness',
                '85%',
                'présence moyenne',
                WellnessColors.warningWarm,
                0.85,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                '💚',
                'Bienveillance',
                '12',
                'moments positifs',
                WellnessColors.successGentle,
                0.8,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                '🌱',
                'Croissance',
                '3',
                'semaines actives',
                WellnessColors.primaryBlue,
                0.6,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    String emoji,
    String title,
    String value,
    String subtitle,
    Color color,
    double progress,
  ) {
    return WellnessCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  emoji,
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: WellnessTextStyles.labelLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: WellnessTextStyles.heading2.copyWith(color: color),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: WellnessTextStyles.bodyTextSmall,
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: color.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              borderRadius: BorderRadius.circular(4),
              minHeight: 6,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodDiscoveries() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Vos découvertes cette semaine ✨',
              style: WellnessTextStyles.heading3,
            ),
            const Spacer(),
            TextButton(
              onPressed: () => _showAllDiscoveries,
              child: Text(
                'Voir tout',
                style: WellnessTextStyles.bodyTextSmall.copyWith(
                  color: WellnessColors.primaryBlue,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        WellnessCard(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: WellnessColors.secondaryGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '🥑',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Avocat bio',
                            style: WellnessTextStyles.labelLarge,
                          ),
                          Text(
                            'Riche en bonnes graisses',
                            style: WellnessTextStyles.bodyTextSmall,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: WellnessColors.successGentle,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Nouveau',
                        style: WellnessTextStyles.captionText.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: WellnessColors.accentSoft,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.psychology,
                        color: WellnessColors.primaryBlue,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Votre diversité alimentaire s\'enrichit ! Continuez à explorer avec curiosité.',
                          style: WellnessTextStyles.bodyTextSmall.copyWith(
                            color: WellnessColors.primaryBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMindfulMoments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Moments de pleine conscience 🧘‍♀️',
          style: WellnessTextStyles.heading3,
        ),
        const SizedBox(height: 16),
        WellnessCard(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: WellnessColors.warningWarm.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.self_improvement,
                        color: WellnessColors.warningWarm,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '12 moments mindful',
                            style: WellnessTextStyles.labelLarge,
                          ),
                          Text(
                            'Score de présence moyen: 85%',
                            style: WellnessTextStyles.bodyTextSmall,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Excellent !',
                      style: WellnessTextStyles.bodyTextSmall.copyWith(
                        color: WellnessColors.successGentle,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                WellnessButton(
                  onPressed: () => _startMindfulSession,
                  style: WellnessButtonStyle.soft,
                  icon: Icon(Icons.play_arrow, size: 18),
                  child: Text('Commencer une session'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGentleAchievements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Vos victoires à célébrer 🎉',
              style: WellnessTextStyles.heading3,
            ),
            const Spacer(),
            TextButton(
              onPressed: () => _showAllAchievements,
              child: Text(
                'Voir tout',
                style: WellnessTextStyles.bodyTextSmall.copyWith(
                  color: WellnessColors.primaryBlue,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildAchievementBadge(
                '🌈',
                'Explorateur',
                'Couleurs',
                true,
              ),
              const SizedBox(width: 12),
              _buildAchievementBadge(
                '🧘‍♀️',
                'Mindful',
                'Première semaine',
                true,
              ),
              const SizedBox(width: 12),
              _buildAchievementBadge(
                '📱',
                'Scanner',
                'Premier produit',
                true,
              ),
              const SizedBox(width: 12),
              _buildAchievementBadge(
                '💚',
                'Bienveillance',
                'Auto-compassion',
                false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementBadge(
    String emoji,
    String title,
    String subtitle,
    bool isUnlocked,
  ) {
    return Container(
      width: 120,
      child: WellnessCard(
        backgroundColor: isUnlocked 
            ? WellnessColors.successGentle.withOpacity(0.1)
            : WellnessColors.neutralWarm,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isUnlocked 
                      ? WellnessColors.successGentle.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  emoji,
                  style: TextStyle(
                    fontSize: 24,
                    color: isUnlocked ? null : Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: WellnessTextStyles.labelLarge.copyWith(
                  fontSize: 14,
                  color: isUnlocked 
                      ? WellnessColors.textPrimary 
                      : WellnessColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                subtitle,
                style: WellnessTextStyles.captionText.copyWith(
                  color: isUnlocked 
                      ? WellnessColors.textSecondary 
                      : Colors.grey,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (isUnlocked) ...[
                const SizedBox(height: 4),
                Icon(
                  Icons.check_circle,
                  color: WellnessColors.successGentle,
                  size: 16,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalizedEncouragement() {
    return WellnessCard(
      gradient: WellnessColors.primaryGradient,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '💌',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 12),
                Text(
                  'Message personnalisé',
                  style: WellnessTextStyles.labelLarge.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Bravo ! Vous développez une relation plus consciente et bienveillante avec la nourriture. Votre parcours inspire confiance et sérénité. Continuez à vous écouter avec cette belle sagesse ! ✨',
              style: WellnessTextStyles.bodyText.copyWith(
                color: Colors.white.withOpacity(0.95),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            WellnessButton(
              onPressed: () => _requestNewTip,
              style: WellnessButtonStyle.soft,
              child: Text('Nouveau conseil'),
            ),
          ],
        ),
      ),
    );
  }

  // Actions
  void _showWellnessSettings(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('⚙️ Ouverture des paramètres bien-être...'),
        backgroundColor: WellnessColors.primaryBlue,
      ),
    );
  }

  void _showAllDiscoveries() {
    // Navigation vers toutes les découvertes
  }

  void _showAllAchievements() {
    // Navigation vers tous les achievements
  }

  void _startMindfulSession() {
    // Démarrer session mindfulness
  }

  void _requestNewTip() {
    // Demander nouveau conseil
  }
}
