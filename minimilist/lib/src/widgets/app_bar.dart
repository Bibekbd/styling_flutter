import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/sizing.dart';

/// A flat, white Milligram-style app bar with a hairline bottom border —
/// the web framework's header aesthetic translated to Flutter.
///
/// Use directly as [AppBar] replacement via [MAppBar.build] or embed in
/// Scaffold's `appBar:` slot through this widget factory helper.
class MAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.bottomBorder = true,
    this.backgroundColor,
    this.centerTitle = false,
    this.elevation = 0,
  });

  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final bool bottomBorder;
  final Color? backgroundColor;
  final bool centerTitle;

  /// Kept at 0 to stay faithful to Milligram's shadowless header.
  final double elevation;

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleWidget ??
          (title != null
              ? Text(title!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                    color: MinimilistColors.textDark,
                  ))
              : null),
      actions: actions,
      leading: leading,
      centerTitle: centerTitle,
      elevation: elevation,
      scrolledUnderElevation: 0,
      backgroundColor: backgroundColor ?? context.themeBg,
      automaticallyImplyLeading: leading != null,
      bottom: bottomBorder
          ? const PreferredSize(
              preferredSize: Size.fromHeight(MinimilistSpacing.borderWidth),
              child: ColoredBox(color: MinimilistColors.border),
            )
          : null,
    );
  }
}

extension on BuildContext {
  Color get themeBg => Theme.of(this).colorScheme.surface;
}
