import 'package:flutter/material.dart';

/// Spacing / sizing tokens ported from Milligram's `_Variables.scss`
/// and `_Grid.scss`.
class MinimilistSpacing {
  MinimilistSpacing._();

  /// Milligram rem base (html font-size: 62.5% => 1rem = 10px).
  static const double rem = 10.0;

  /// Grid container max-width — Milligram `.container` is 96rem (960px).
  static const double containerMaxWidth = 960.0;

  /// Horizontal padding of the container (1rem on mobile, more on desktop).
  static const double containerPadding = 20.0;

  /// Gutter between grid columns — Milligram uses 1% margins each side.
  static const double gridGutter = 15.0;

  /// Default vertical rhythm between blocks (Milligram margins ~2.5rem).
  static const double blockSpacing = 25.0;

  /// Border radius — Milligram `$border-radius: 4px`.
  static const double borderRadius = 4.0;

  /// Pill radius for buttons — Milligram buttons use `4px` but look soft;
  /// we keep 4px to stay faithful.
  static const double buttonRadius = 4.0;

  /// Input height baseline (Milligram inputs have 6px 10px padding + line).
  static const double controlHeight = 44.0;

  /// Standard border width — Milligram uses 1px borders everywhere.
  static const double borderWidth = 1.0;

  // Convenience paddings
  static const EdgeInsets pagePadding =
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0);
  static const EdgeInsets cardPadding = EdgeInsets.all(24.0);
  static const EdgeInsets fieldMargin = EdgeInsets.only(bottom: 18.0);
}

/// Responsive breakpoint helper mirroring Milligram media queries:
/// 400px, 550px, 800px, 1000px.
enum MinimilistBreakpoint {
  phone(0),
  largePhone(400),
  tablet(550),
  desktop(800),
  wideDesktop(1000);

  const MinimilistBreakpoint(this.minWidth);
  final double minWidth;

  static MinimilistBreakpoint of(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    MinimilistBreakpoint result = phone;
    for (final bp in values) {
      if (w >= bp.minWidth) result = bp;
    }
    return result;
  }

  bool get isCompact => index <= MinimilistBreakpoint.largePhone.index;
}
