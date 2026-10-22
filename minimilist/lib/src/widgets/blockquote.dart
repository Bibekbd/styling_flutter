import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/sizing.dart';

/// A blockquote styled exactly like Milligram's `blockquote`:
/// left accent bar (4px #d8197d or grey), italic body, optional citation.
///
/// ```dart
/// MBlockquote(
///   text: 'Simplicity is the ultimate sophistication.',
///   cite: '— Leonardo da Vinci',
/// )
/// ```
class MBlockquote extends StatelessWidget {
  const MBlockquote({
    super.key,
    required this.text,
    this.cite,
    this.color,
  });

  final String text;
  final String? cite;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final accent = color ?? MinimilistColors.border;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: MinimilistSpacing.rem),
      padding: const EdgeInsets.only(left: 20, top: 4, bottom: 4),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: accent, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '"$text"',
            style: const TextStyle(
              fontSize: 17,
              fontStyle: FontStyle.italic,
              height: 1.6,
              color: MinimilistColors.text,
            ),
          ),
          if (cite != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                cite!,
                style: const TextStyle(
                  fontSize: 14,
                  color: MinimilistColors.textLight,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
