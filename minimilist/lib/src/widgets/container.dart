import 'package:flutter/material.dart';

import '../theme/sizing.dart';

/// The Flutter port of Milligram's `.container` — centers content and
/// constrains it to 960px with comfortable horizontal padding, exactly
/// like the web framework.
///
/// ```dart
/// MContainer(
///   child: Column(children: [...]),
/// )
/// ```
class MContainer extends StatelessWidget {
  const MContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(
      horizontal: MinimilistSpacing.containerPadding,
    ),
    this.maxWidth = MinimilistSpacing.containerMaxWidth,
  });

  final Widget child;
  final EdgeInsets padding;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
