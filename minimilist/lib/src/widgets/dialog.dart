import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/sizing.dart';
import 'button.dart';

/// A minimal confirmation dialog in the Milligram visual language:
/// light-weight title, body copy, outlined "cancel" + filled "confirm".
///
/// ```dart
/// final ok = await MDialog.confirm(
///   context,
///   title: 'Delete post?',
///   message: 'This action cannot be undone.',
///   confirmLabel: 'Delete',
/// );
/// ```
class MDialog {
  MDialog._();

  static Future<bool?> confirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'OK',
    String? cancelLabel = 'Cancel',
    bool destructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 15,
            height: 1.6,
            color: MinimilistColors.text,
          ),
        ),
        actionsPadding:
            const EdgeInsets.fromLTRB(24, 8, 24, 24),
        actions: [
          if (cancelLabel != null)
            MButton(
              label: cancelLabel,
              variant: MButtonVariant.outlined,
              onPressed: () => Navigator.of(dialogContext).pop(false),
            ),
          const SizedBox(width: 10),
          MButton(
            label: confirmLabel,
            color: destructive ? MinimilistColors.error : null,
            onPressed: () => Navigator.of(dialogContext).pop(true),
          ),
        ],
      ),
    );
  }

  /// A generic Milligram-styled dialog with arbitrary content.
  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    required Widget child,
    List<Widget>? actions,
  }) {
    return showDialog<T>(
      context: context,
      builder: (_) => AlertDialog(
        title: title != null ? Text(title) : null,
        content: child,
        actions: actions,
      ),
    );
  }
}

/// A bottom sheet with a grab handle and Milligram container padding.
Future<T?> mShowBottomSheet<T>(
  BuildContext context, {
  required Widget child,
  bool isScrollControlled = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(MinimilistSpacing.borderRadius * 2),
      ),
    ),
    builder: (sheetContext) => Padding(
      padding: EdgeInsets.only(
        left: MinimilistSpacing.containerPadding,
        right: MinimilistSpacing.containerPadding,
        top: 12,
        bottom: MediaQuery.viewInsetsOf(sheetContext).bottom + 20,
      ),
      child: child,
    ),
  );
}
