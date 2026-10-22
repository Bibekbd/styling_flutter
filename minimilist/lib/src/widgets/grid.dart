import 'package:flutter/material.dart';

import '../theme/sizing.dart';

/// Fractional widths mirroring Milligram grid classes:
/// `one`, `one-half`, `one-third`, `two-thirds`, `one-fourth`,
/// `three-fourths`, `full` — expressed as a fraction of 12 columns.
enum MWidth {
  one(1),
  oneSixth(2),
  oneFourth(3),
  oneThird(4),
  fiveTwelfths(5),
  oneHalf(6),
  sevenTwelfths(7),
  twoThirds(8),
  threeFourths(9),
  fiveSixths(10),
  elevenTwelfths(11),
  full(12);

  const MWidth(this.columns);

  /// Number of the 12 grid columns this width occupies.
  final int columns;

  double get fraction => columns / 12.0;
}

/// Inherited helper so [MColumn] knows whether its [MRow] is currently
/// laid out horizontally or stacked vertically.
class MRowScope extends InheritedWidget {
  const MRowScope({
    super.key,
    required this.isHorizontal,
    required super.child,
  });

  final bool isHorizontal;

  static MRowScope? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MRowScope>();

  @override
  bool updateShouldNotify(MRowScope oldWidget) =>
      isHorizontal != oldWidget.isHorizontal;
}

/// A single column inside an [MRow] — the Flutter port of Milligram's
/// `.column` element with its `data-*` width attributes.
class MColumn extends StatelessWidget {
  const MColumn({
    super.key,
    required this.child,
    this.width = MWidth.full,
    this.gutter = MinimilistSpacing.gridGutter,
  });

  final Widget child;
  final MWidth width;

  /// Horizontal gutter (half applied to each side), like Milligram's
  /// margins on each side of a column.
  final double gutter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: gutter / 2),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final scope = MRowScope.maybeOf(context);
          final parentIsRow = scope != null && scope.isHorizontal;
          // Inside a collapsed (stacked) row we always take full width.
          final effectiveFraction = parentIsRow ? width.fraction : 1.0;
          return SizedBox(
            width: constraints.maxWidth * effectiveFraction,
            child: child,
          );
        },
      ),
    );
  }
}

/// A responsive 12-column row — the Flutter port of Milligram's `.row`.
///
/// Below the `tablet` breakpoint (550px) columns stack at full width,
/// exactly like Milligram's media queries.
///
/// ```dart
/// MRow(children: const [
///   MColumn(width: MWidth.oneThird, child: Text('1/3')),
///   MColumn(width: MWidth.twoThirds, child: Text('2/3')),
/// ])
/// ```
class MRow extends StatelessWidget {
  const MRow({
    super.key,
    required this.children,
    this.gap = MinimilistSpacing.gridGutter,
  });

  final List<MColumn> children;

  /// Vertical gap used when the row collapses into a stack.
  final double gap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const tablet = 550.0; // MinimilistBreakpoint.tablet.minWidth
        final horizontal = constraints.maxWidth >= tablet;

        if (!horizontal) {
          return MRowScope(
            isHorizontal: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < children.length; i++) ...[
                  if (i > 0) SizedBox(height: gap),
                  children[i],
                ],
              ],
            ),
          );
        }

        return MRowScope(
          isHorizontal: true,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [for (final c in children) Flexible(child: c)],
          ),
        );
      },
    );
  }
}
