import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/sizing.dart';

/// Show a Milligram-styled floating snackbar with an optional action.
///
/// ```dart
/// MSnackBar.show(context, message: 'Saved!', actionLabel: 'Undo',
///   onAction: undo);
/// ```
class MSnackBar {
  MSnackBar._();

  static void show(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: const TextStyle(color: Colors.white)),
          backgroundColor: backgroundColor ?? MinimilistColors.textDark,
          duration: duration,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(MinimilistSpacing.rem),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(MinimilistSpacing.borderRadius),
          ),
          action: (actionLabel != null && onAction != null)
              ? SnackBarAction(
                  label: actionLabel,
                  textColor: Theme.of(context).colorScheme.primary,
                  onPressed: onAction,
                )
              : null,
        ),
      );
  }
}
