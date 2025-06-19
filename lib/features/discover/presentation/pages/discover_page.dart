import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/wellness_colors.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../shared/widgets/wellness_card.dart';
import '../../../../shared/widgets/encouragement_banner.dart';

class DiscoverPage extends ConsumerWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: WellnessColors.backgroundCream,
      body: CustomScrollView(
        slivers: [
          // Header bienveillant
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: false,
            backgroundColor: WellnessColors.primaryBlue,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: WellnessColors.primaryGradient,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getGreetingMessage(),
                          style: WellnessTextStyles.heading2.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Prêt(e) pour une journée bienveillante ?',
                          style: WellnessTextStyles.bodyText.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Contenu principal
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Banner d'encouragement du jour
                const EncouragementBanner(),
                
                const SizedBox(height: 24),
                
                // Actions rapides
                _buildQuickActions(context),
                
                const SizedBox(height: 24),
                
                // Découvertes du jour
                _buildTodaysDiscoveries(),
                
                const SizedBox(height: 24),
                
                // Tips bienveillants
                _buildWellnessTips(),
                
                const SizedBox(height: 24),
                
                // Votre parcours
                _buildJourneyOverview(),
                
                const SizedBox(height: 100), // Espace pour navigation
              ]),
            ),
          ),
        ],
      ),
    );
  }

  String _getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return '🌅 Bonjour !';
    } else if (hour < 17) {
      return '☀️ Bon après-midi !';
    } else {
      return '🌙 Bonsoir !';
    }
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Actions rapides',
          style: WellnessTextStyles.heading3,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                context,
                icon: Icons.qr_code_scanner,
                title: 'Scanner',
                subtitle: 'Découvrir un produit',
                color: WellnessColors.primaryBlue,
                onTap: () => _navigateToScanner(context),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                context,
                icon: Icons.edit_note,
                title: 'Ajouter',
                subtitle: 'Nouveau repas',
                color: WellnessColors.secondaryGreen,
                onTap: () => _navigateToJournal(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                context,
                icon: Icons.self_improvement,
                title: 'Mindfulness',
                subtitle: 'Moment présent',
                color: WellnessColors.warningWarm,
                onTap: () => _startMindfulMoment(context),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                context,
                icon: Icons.insights,
                title: 'Bien-être',
                subtitle: 'Votre parcours',
                color: WellnessColors.successGentle,
                onTap: () => _navigateToWellness(context),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return WellnessCard(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: WellnessTextStyles.labelLarge,
              textAlign: TextAlign.center,
            ),
            Text(
              subtitle,
              style: WellnessTextStyles.bodyTextSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodaysDiscoveries() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Découvertes du jour 🌟',
          style: WellnessTextStyles.heading3,
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
                    Text(
                      '🥗',
                      style: TextStyle(fontSize: 32),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Légumes de saison',
                            style: WellnessTextStyles.labelLarge,
                          ),
                          Text(
                            'Les épinards frais sont riches en fer et vitamines',
                            style: WellnessTextStyles.bodyTextSmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: WellnessColors.secondaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '💡 Tip du jour',
                    style: WellnessTextStyles.captionText.copyWith(
                      color: WellnessColors.secondaryGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWellnessTips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Conseils bienveillants 💚',
          style: WellnessTextStyles.heading3,
        ),
        const SizedBox(height: 16),
        WellnessCard(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🧘‍♀️ Prenez trois respirations profondes avant de manger',
                  style: WellnessTextStyles.bodyText,
                ),
                const SizedBox(height: 12),
                Text(
                  'Cette simple pratique vous aide à vous connecter à votre corps et à savourer pleinement votre repas.',
                  style: WellnessTextStyles.bodyTextSmall,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => _startMindfulMoment,
                  icon: const Icon(Icons.play_arrow, size: 18),
                  label: const Text('Essayer maintenant'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: WellnessColors.accentSoft,
                    foregroundColor: WellnessColors.primaryBlue,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildJourneyOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Votre parcours 🌱',
          style: WellnessTextStyles.heading3,
        ),
        const SizedBox(height: 16),
        WellnessCard(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('3', 'Jours', WellnessColors.primaryBlue),
                    _buildStatItem('12', 'Découvertes', WellnessColors.secondaryGreen),
                    _buildStatItem('5', 'Moments mindful', WellnessColors.warningWarm),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: WellnessColors.successGentle.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.emoji_events,
                        color: WellnessColors.successGentle,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Bravo ! Vous développez une relation plus consciente avec la nourriture',
                          style: WellnessTextStyles.bodyTextSmall.copyWith(
                            color: WellnessColors.successGentle,
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

  Widget _buildStatItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: WellnessTextStyles.heading2.copyWith(color: color),
        ),
        Text(
          label,
          style: WellnessTextStyles.bodyTextSmall,
        ),
      ],
    );
  }

  // Navigation methods
  void _navigateToScanner(BuildContext context) {
    // Dans l'implémentation réelle, vous utiliseriez Navigator ou GoRouter
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🔍 Ouverture du scanner...'),
        backgroundColor: WellnessColors.primaryBlue,
      ),
    );
  }

  void _navigateToJournal(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('📖 Ouverture du journal...'),
        backgroundColor: WellnessColors.secondaryGreen,
      ),
    );
  }

  void _navigateToWellness(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('💚 Ouverture du tableau de bord bien-être...'),
        backgroundColor: WellnessColors.successGentle,
      ),
    );
  }

  void _startMindfulMoment(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🧘‍♀️ Démarrage de la session mindfulness...'),
        backgroundColor: WellnessColors.warningWarm,
      ),
    );
  }
}
