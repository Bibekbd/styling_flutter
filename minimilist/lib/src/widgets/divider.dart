import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/sizing.dart';

/// Milligram's `<hr>` — a single 1px #ddd rule with generous vertical
/// breathing room (3rem top/bottom on the web).
class MDivider extends StatelessWidget {
  const MDivider({super.key, this.color, this.space = MinimilistSpacing.blockSpacing});

  final Color? color;
  final double space;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: space),
      height: MinimilistSpacing.borderWidth,
      color: color ?? MinimilistColors.border,
    );
  }
}
