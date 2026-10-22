import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/sizing.dart';

/// Semantic tone for [MBadge] / [MAlert].
enum MTone { neutral, primary, success, warning, error, info }

Color _toneColor(MTone tone) => switch (tone) {
      MTone.neutral => MinimilistColors.textLight,
      MTone.primary => MinimilistColors.primary,
      MTone.success => MinimilistColors.success,
      MTone.warning => MinimilistColors.warning,
      MTone.error => MinimilistColors.error,
      MTone.info => MinimilistColors.info,
    };

/// A small pill badge — counts, statuses, tags. 4px radius, white label.
class MBadge extends StatelessWidget {
  const MBadge(this.text, {super.key, this.tone = MTone.primary, this.outline = false});

  final String text;
  final MTone tone;

  /// Transparent background with colored border & label (Milligram
  /// "outline" flavour).
  final bool outline;

  @override
  Widget build(BuildContext context) {
    final color = _toneColor(tone);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: outline ? Colors.transparent : color,
        borderRadius: BorderRadius.circular(MinimilistSpacing.borderRadius),
        border: outline ? Border.all(color: color) : null,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: outline ? color : Colors.white,
        ),
      ),
    );
  }
}

/// An inline alert banner (`div.alert`): tinted surface, left accent and
/// a dismiss option — used for form/notice feedback.
class MAlert extends StatelessWidget {
  const MAlert({
    super.key,
    required this.message,
    this.title,
    this.tone = MTone.info,
    this.onDismiss,
    this.icon,
  });

  final String message;
  final String? title;
  final MTone tone;
  final VoidCallback? onDismiss;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final color = _toneColor(tone);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: MinimilistSpacing.blockSpacing),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(MinimilistSpacing.borderRadius),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      title!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                Text(
                  message,
                  style: const TextStyle(
                      fontSize: 15, color: MinimilistColors.text),
                ),
              ],
            ),
          ),
          if (onDismiss != null)
            InkWell(
              onTap: onDismiss,
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.close, size: 18,
                    color: MinimilistColors.textLight),
              ),
            ),
        ],
      ),
    );
  }
}
