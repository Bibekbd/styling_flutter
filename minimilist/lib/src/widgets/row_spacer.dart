import 'package:flutter/material.dart';

import '../theme/sizing.dart';

/// A vertical spacer replicating Milligram's rhythmic margins between
/// blocks (headings, paragraphs, buttons all get generous spacing).
class MSpacer extends StatelessWidget {
  const MSpacer([this.height = MinimilistSpacing.blockSpacing, super.key]);

  final double height;

  @override
  Widget build(BuildContext context) => SizedBox(height: height);
}

/// Half-size spacer (1.25rem rhythm in Milligram terms).
class MHalfSpacer extends StatelessWidget {
  const MHalfSpacer({super.key});

  @override
  Widget build(BuildContext context) =>
      const SizedBox(height: MinimilistSpacing.blockSpacing / 2);
}
