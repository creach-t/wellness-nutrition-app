import 'package:flutter/material.dart';
import 'dart:math';

import '../../core/constants/app_constants.dart';
import '../../core/constants/wellness_colors.dart';
import '../../core/themes/app_theme.dart';
import 'wellness_card.dart';

class EncouragementBanner extends StatefulWidget {
  const EncouragementBanner({super.key});

  @override
  State<EncouragementBanner> createState() => _EncouragementBannerState();
}

class _EncouragementBannerState extends State<EncouragementBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late String _currentMessage;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _currentMessage = _getRandomEncouragementMessage();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _getRandomEncouragementMessage() {
    final messages = AppConstants.encouragementMessages;
    final random = Random();
    return messages[random.nextInt(messages.length)];
  }

  void _refreshMessage() {
    _animationController.reverse().then((_) {
      setState(() {
        _currentMessage = _getRandomEncouragementMessage();
      });
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: WellnessCard(
        gradient: WellnessColors.sunsetGradient,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '✨',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Message du jour',
                          style: WellnessTextStyles.labelLarge.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        _currentMessage,
                        key: ValueKey(_currentMessage),
                        style: WellnessTextStyles.bodyText.copyWith(
                          color: Colors.white.withOpacity(0.95),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              HeartbeatAnimation(
                child: IconButton(
                  onPressed: _refreshMessage,
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                  tooltip: 'Nouveau message',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MindfulnessPrompt extends StatelessWidget {
  const MindfulnessPrompt({super.key});

  @override
  Widget build(BuildContext context) {
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
                  Icons.self_improvement,
                  color: WellnessColors.primaryBlue,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Moment mindful',
                  style: WellnessTextStyles.labelLarge.copyWith(
                    color: WellnessColors.primaryBlue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              AppConstants.mindfulnessPrompts[
                Random().nextInt(AppConstants.mindfulnessPrompts.length)
              ],
              style: WellnessTextStyles.bodyTextSmall.copyWith(
                color: WellnessColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WellnessQuote extends StatelessWidget {
  const WellnessQuote({
    super.key,
    required this.quote,
    required this.author,
    this.backgroundColor,
  });

  final String quote;
  final String author;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return WellnessCard(
      backgroundColor: backgroundColor ?? WellnessColors.neutralWarm,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.format_quote,
              color: WellnessColors.primaryBlue.withOpacity(0.6),
              size: 32,
            ),
            const SizedBox(height: 12),
            Text(
              quote,
              style: WellnessTextStyles.bodyText.copyWith(
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '— $author',
                style: WellnessTextStyles.bodyTextSmall.copyWith(
                  fontWeight: FontWeight.w500,
                  color: WellnessColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DailyTip extends StatelessWidget {
  const DailyTip({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
    this.onTap,
  });

  final String title;
  final String content;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return WellnessCard(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: WellnessColors.secondaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: WellnessColors.secondaryGreen,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: WellnessTextStyles.labelLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    content,
                    style: WellnessTextStyles.bodyTextSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.arrow_forward_ios,
                color: WellnessColors.textSecondary,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }
}

class ProgressCard extends StatelessWidget {
  const ProgressCard({
    super.key,
    required this.title,
    required this.progress,
    required this.total,
    this.subtitle,
    this.color,
  });

  final String title;
  final int progress;
  final int total;
  final String? subtitle;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final progressValue = total > 0 ? progress / total : 0.0;
    final progressColor = color ?? WellnessColors.primaryBlue;

    return WellnessCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: WellnessTextStyles.labelLarge,
                ),
                Text(
                  '$progress/$total',
                  style: WellnessTextStyles.bodyTextSmall.copyWith(
                    color: progressColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                style: WellnessTextStyles.bodyTextSmall,
              ),
            ],
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progressValue,
              backgroundColor: progressColor.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              borderRadius: BorderRadius.circular(8),
              minHeight: 8,
            ),
          ],
        ),
      ),
    );
  }
}

class AchievementBadge extends StatelessWidget {
  const AchievementBadge({
    super.key,
    required this.emoji,
    required this.title,
    required this.description,
    this.isUnlocked = false,
    this.onTap,
  });

  final String emoji;
  final String title;
  final String description;
  final bool isUnlocked;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return WellnessCard(
      onTap: onTap,
      backgroundColor: isUnlocked 
          ? WellnessColors.successGentle.withOpacity(0.1)
          : WellnessColors.neutralWarm,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isUnlocked 
                    ? WellnessColors.successGentle.withOpacity(0.2)
                    : Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Text(
                  emoji,
                  style: TextStyle(
                    fontSize: 24,
                    color: isUnlocked ? null : Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: WellnessTextStyles.labelLarge.copyWith(
                      color: isUnlocked 
                          ? WellnessColors.textPrimary 
                          : WellnessColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: WellnessTextStyles.bodyTextSmall.copyWith(
                      color: isUnlocked 
                          ? WellnessColors.textSecondary 
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            if (isUnlocked)
              Icon(
                Icons.check_circle,
                color: WellnessColors.successGentle,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.actionText,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String description;
  final String? actionText;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: WellnessColors.textSecondary.withOpacity(0.6),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: WellnessTextStyles.heading3.copyWith(
                color: WellnessColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: WellnessTextStyles.bodyText.copyWith(
                color: WellnessColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionText != null && onAction != null) ...[
              const SizedBox(height: 24),
              WellnessButton(
                onPressed: onAction,
                style: WellnessButtonStyle.soft,
                child: Text(actionText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
