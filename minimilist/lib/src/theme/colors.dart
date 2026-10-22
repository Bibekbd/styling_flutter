import 'package:flutter/material.dart';

/// Color tokens ported from Milligram's `_Variables.scss`.
///
/// Milligram palette:
/// - $color: #606c76 (body text)
/// - $secondary-color: #1982fc -> in newer versions #d8197d / brand pink
///   (Milligram uses a magenta/pink accent `#d8197d` for links & buttons)
/// - $border-radius: 4px
/// - greys: #f4f5f6 (code background), #ddd (borders), #bbb, #888, #333
class MinimilistColors {
  MinimilistColors._();

  /// Primary body text color — Milligram `$color: #606c76`.
  static const Color text = Color(0xFF606C76);

  /// Softer secondary text — used for hints, captions.
  static const Color textLight = Color(0xFF888888);

  /// Darkest grey — headings emphasis / hover states.
  static const Color textDark = Color(0xFF313131);

  /// Brand accent — Milligram link/primary button color `#d8197d`.
  static const Color primary = Color(0xFFD8197D);

  /// Darker shade of [primary] for pressed/hover states (`#b3125f`).
  static const Color primaryDark = Color(0xFFB3125F);

  /// Secondary action color — Milligram "outlined" hover blue `#1982fc`.
  static const Color secondary = Color(0xFF1982FC);

  /// Classic Milligram border grey `#ddd`.
  static const Color border = Color(0xFFDDDDDD);

  /// Even lighter divider grey.
  static const Color borderLight = Color(0xFFEEEEEE);

  /// Placeholder / disabled grey `#bbb`.
  static const Color placeholder = Color(0xFFBBBBBB);

  /// Very light surface (Milligram code block bg) `#f4f5f6`.
  static const Color surface = Color(0xFFF4F5F6);

  /// App background — Milligram keeps pure white.
  static const Color background = Colors.white;

  /// Success green.
  static const Color success = Color(0xFF0C9A61);

  /// Warning amber.
  static const Color warning = Color(0xFFFFBF00);

  /// Error red.
  static const Color error = Color(0xFFE3060C);

  /// Info blue.
  static const Color info = Color(0xFF3D95CE);

  // ---- Dark variant tokens (for MinimilistTheme.dark) ----
  static const Color darkBackground = Color(0xFF1E1E24);
  static const Color darkSurface = Color(0xFF2A2A32);
  static const Color darkText = Color(0xFFD4D4DC);
  static const Color darkTextLight = Color(0xFF9A9AA5);
  static const Color darkBorder = Color(0xFF3C3C46);
}
