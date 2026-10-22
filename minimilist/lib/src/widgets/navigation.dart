import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/sizing.dart';

/// A navigation item for [MNavBar].
class MNavItem {
  const MNavItem({required this.label, this.icon, this.onTap, this.badge});

  final String label;
  final IconData? icon;
  final VoidCallback? onTap;

  /// Optional trailing count badge.
  final String? badge;
}

/// A horizontal text navigation bar — the Flutter port of Milligram's
/// `.navigation` menu: light-weight links, accent color on the active
/// item, hairline separators optional.
class MNavBar extends StatelessWidget {
  const MNavBar({
    super.key,
    required this.items,
    this.selectedIndex,
    this.brand,
  });

  final List<MNavItem> items;
  final int? selectedIndex;

  /// Left-side brand text (like a site title in a web navbar).
  final String? brand;

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).colorScheme.primary;
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: MinimilistColors.border)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          if (brand != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                brand!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: MinimilistColors.textDark,
                ),
              ),
            ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var i = 0; i < items.length; i++)
                    _NavItemButton(
                      item: items[i],
                      active: i == selectedIndex,
                      accent: accent,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItemButton extends StatelessWidget {
  const _NavItemButton({
    required this.item,
    required this.active,
    required this.accent,
  });

  final MNavItem item;
  final bool active;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      borderRadius:
          BorderRadius.circular(MinimilistSpacing.borderRadius),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            if (item.icon != null) ...[
              Icon(item.icon,
                  size: 18,
                  color: active ? accent : MinimilistColors.text),
              const SizedBox(width: 6),
            ],
            Text(
              item.label,
              style: TextStyle(
                fontSize: 15,
                color: active ? accent : MinimilistColors.text,
                fontWeight: active ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            if (item.badge != null) ...[
              const SizedBox(width: 6),
              MBadgeInline(text: item.badge!),
            ],
          ],
        ),
      ),
    );
  }
}

/// Tiny inline count pill used by nav items and list tiles.
class MBadgeInline extends StatelessWidget {
  const MBadgeInline({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
      decoration: BoxDecoration(
        color: MinimilistColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 11, color: Colors.white),
      ),
    );
  }
}

/// A bottom tab bar with Milligram styling (delegates to the theme).
class MBottomNav extends StatelessWidget {
  const MBottomNav({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<MNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: MinimilistColors.textLight,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      elevation: 0,
      items: [
        for (final item in items)
          BottomNavigationBarItem(
            icon: Icon(item.icon ?? Icons.circle, size: 22),
            label: item.label,
          ),
      ],
    );
  }
}
