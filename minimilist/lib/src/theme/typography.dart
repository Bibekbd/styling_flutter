import 'package:flutter/material.dart';

import 'colors.dart';

/// Typography scale ported from Milligram's `_Typography.scss`.
///
/// Milligram base: font-size 1.5rem (15px), line-height 1.6, font-weight 400,
/// Roboto with system fallbacks. Headings are light (weight 300) and
/// margin-scaled: h1 4.0rem, h2 3.6rem, h3 3.0rem, h4 2.4rem,
/// h5 1.8rem, h6 1.6rem (all rem = 10px base in Milligram).
class MinimilistTypography {
  MinimilistTypography._();

  /// The typeface used across the package. Falls back gracefully when the
  /// font is not bundled — declare `google_fonts` or bundle Roboto to match
  /// Milligram exactly.
  static const String fontFamily = 'Roboto';

  static const double baseFontSize = 15.0; // 1.5rem
  static const double lineHeight = 1.6;

  static TextTheme textTheme({Color primary = MinimilistColors.text}) {
    const secondary = MinimilistColors.textDark;

    TextStyle heading(double size) => TextStyle(
          fontSize: size,
          fontWeight: FontWeight.w300, // Milligram headings are light
          letterSpacing: 0,
          height: 1.25,
          color: secondary,
        );

    return TextTheme(
      displayLarge: heading(40.0), // h1 — 4.0rem
      displayMedium: heading(36.0), // h2 — 3.6rem
      displaySmall: heading(30.0), // h3 — 3.0rem
      headlineMedium: heading(24.0), // h4 — 2.4rem
      headlineSmall: heading(18.0), // h5 — 1.8rem
      titleLarge: heading(16.0), // h6 — 1.6rem
      titleMedium: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: secondary,
      ),
      bodyLarge: TextStyle(
        fontSize: baseFontSize + 1,
        height: lineHeight,
        color: primary,
      ),
      bodyMedium: const TextStyle(
        fontSize: baseFontSize,
        height: lineHeight,
        color: primary,
      ),
      bodySmall: TextStyle(
        fontSize: 13.0,
        height: lineHeight,
        color: primary.withValues(alpha: 0.75),
      ),
      labelLarge: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
        color: Colors.white,
      ),
      labelMedium: const TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        color: secondary,
      ),
      labelSmall: const TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: MinimilistColors.textLight,
      ),
    );
  }

  /// Dark-theme text theme variant.
  static TextTheme darkTextTheme() => textTheme(
        primary: MinimilistColors.darkText,
      ).apply(
        bodyColor: MinimilistColors.darkText,
        displayColor: Colors.white,
      );
}
