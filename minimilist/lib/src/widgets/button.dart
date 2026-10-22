import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/sizing.dart';

/// Button variants mirroring Milligram's button classes:
/// - [filled] — default `.button` (solid accent, white label)
/// - [outlined] — `.button-outline` (transparent, accent border/label,
///   fills on press like the web hover)
/// - [text] — bare text acting as a link-style button
enum MButtonVariant { filled, outlined, text }

/// A Milligram-styled button.
///
/// Milligram buttons: 4px radius, generous horizontal padding (30px),
/// centered label, subtle transform on press (we map it to Material's
/// splash + scale-free elevation 0).
///
/// ```dart
/// MButton(label: 'Send', onPressed: submit)
/// MButton(label: 'Cancel', variant: MButtonVariant.outlined, onPressed: reset)
/// ```
class MButton extends StatelessWidget {
  const MButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = MButtonVariant.filled,
    this.color,
    this.expand = false,
    this.icon,
    this.busy = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final MButtonVariant variant;
  final Color? color;
  final bool expand;
  final IconData? icon;
  final bool busy;

  bool get _enabled => onPressed != null && !busy;

  @override
  Widget build(BuildContext context) {
    final accent = color ?? Theme.of(context).colorScheme.primary;

    final child = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (busy)
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: variant == MButtonVariant.filled
                  ? Colors.white
                  : accent,
            ),
          )
        else if (icon != null)
          Icon(icon, size: 18, color: _foreground(accent)),
        if (busy || icon != null) const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(color: _foreground(accent)),
        ),
      ],
    );

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(MinimilistSpacing.buttonRadius),
    );

    final button = switch (variant) {
      MButtonVariant.filled => ElevatedButton(
          onPressed: _enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _enabled ? accent : MinimilistColors.placeholder,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: shape,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          ),
          child: DefaultTextStyle.merge(
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            child: child,
          ),
        ),
      MButtonVariant.outlined => OutlinedButton(
          onPressed: _enabled ? onPressed : null,
          style: OutlinedButton.styleFrom(
            foregroundColor: accent,
            side: BorderSide(
              color: _enabled ? accent : MinimilistColors.placeholder,
            ),
            shape: shape,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          ),
          child: DefaultTextStyle.merge(
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            child: child,
          ),
        ),
      MButtonVariant.text => TextButton(
          onPressed: _enabled ? onPressed : null,
          style: TextButton.styleFrom(foregroundColor: accent),
          child: child,
        ),
    };

    return IntrinsicWidth(
      child: expand ? SizedBox(width: double.infinity, child: button) : button,
    );
  }

  Color _foreground(Color accent) => switch (variant) {
        MButtonVariant.filled => Colors.white,
        MButtonVariant.outlined || MButtonVariant.text => accent,
      };
}

/// A full-width button row that distributes buttons like Milligram's
/// grid of adjacent buttons.
class MButtonGroup extends StatelessWidget {
  const MButtonGroup({super.key, required this.children, this.spacing = 10});

  final List<Widget> children;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: children,
    );
  }
}
