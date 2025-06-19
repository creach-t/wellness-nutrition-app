import 'package:flutter/material.dart';
import '../../core/constants/wellness_colors.dart';

class WellnessCard extends StatelessWidget {
  const WellnessCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.elevation,
    this.gradient,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final double? elevation;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final cardContent = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: gradient == null ? (backgroundColor ?? Colors.white) : null,
        gradient: gradient,
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: elevation ?? 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );

    if (onTap != null) {
      return Container(
        margin: margin,
        child: Material(
          color: Colors.transparent,
          borderRadius: borderRadius ?? BorderRadius.circular(16),
          child: InkWell(
            onTap: onTap,
            borderRadius: borderRadius ?? BorderRadius.circular(16),
            child: cardContent,
          ),
        ),
      );
    }

    return Container(
      margin: margin,
      child: cardContent,
    );
  }
}

class WellnessButton extends StatelessWidget {
  const WellnessButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.borderRadius,
    this.elevation,
    this.style = WellnessButtonStyle.primary,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double? elevation;
  final WellnessButtonStyle style;

  @override
  Widget build(BuildContext context) {
    final colors = _getColorsForStyle(style);
    
    if (icon != null) {
      return ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon!,
        label: child,
        style: _getButtonStyle(colors),
      );
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: _getButtonStyle(colors),
      child: child,
    );
  }

  ButtonStyle _getButtonStyle(_ButtonColors colors) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? colors.background,
      foregroundColor: foregroundColor ?? colors.foreground,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(25),
      ),
      elevation: elevation ?? 2,
      shadowColor: colors.shadow,
    );
  }

  _ButtonColors _getColorsForStyle(WellnessButtonStyle style) {
    switch (style) {
      case WellnessButtonStyle.primary:
        return _ButtonColors(
          background: WellnessColors.primaryBlue,
          foreground: Colors.white,
          shadow: WellnessColors.primaryBlue.withOpacity(0.3),
        );
      case WellnessButtonStyle.secondary:
        return _ButtonColors(
          background: WellnessColors.secondaryGreen,
          foreground: Colors.white,
          shadow: WellnessColors.secondaryGreen.withOpacity(0.3),
        );
      case WellnessButtonStyle.soft:
        return _ButtonColors(
          background: WellnessColors.accentSoft,
          foreground: WellnessColors.primaryBlue,
          shadow: Colors.black.withOpacity(0.1),
        );
      case WellnessButtonStyle.outline:
        return _ButtonColors(
          background: Colors.transparent,
          foreground: WellnessColors.primaryBlue,
          shadow: Colors.transparent,
        );
    }
  }
}

enum WellnessButtonStyle {
  primary,
  secondary,
  soft,
  outline,
}

class _ButtonColors {
  const _ButtonColors({
    required this.background,
    required this.foreground,
    required this.shadow,
  });

  final Color background;
  final Color foreground;
  final Color shadow;
}

class WellnessContainer extends StatelessWidget {
  const WellnessContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.decoration,
    this.width,
    this.height,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: decoration ??
          BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
      child: child,
    );
  }
}

// Animations bienveillantes
class WellnessAnimations {
  static const Duration gentle = Duration(milliseconds: 300);
  static const Duration soft = Duration(milliseconds: 200);
  static const Duration heartbeat = Duration(milliseconds: 1000);
  
  static const Curve easeIn = Curves.easeInOut;
  static const Curve bounce = Curves.elasticOut;
}

class HeartbeatAnimation extends StatefulWidget {
  const HeartbeatAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 2),
    this.enabled = true,
  });

  final Widget child;
  final Duration duration;
  final bool enabled;

  @override
  State<HeartbeatAnimation> createState() => _HeartbeatAnimationState();
}

class _HeartbeatAnimationState extends State<HeartbeatAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    if (widget.enabled) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: widget.child,
        );
      },
    );
  }
}
