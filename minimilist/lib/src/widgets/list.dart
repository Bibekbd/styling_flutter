import 'package:flutter/material.dart';

import '../theme/colors.dart';

/// List styles mirroring HTML semantics as styled by Milligram:
/// unordered (disc), ordered (decimal) and unstyled (`list-none`).
enum MListStyle { none, disc, decimal }

/// An item in an [MList].
class MListItem {
  const MListItem(this.text, {this.child});

  final String text;

  /// Optional rich widget content rendered instead of plain [text].
  final Widget? child;
}

/// A Milligram-styled list (`<ul>` / `<ol>`): tight vertical rhythm with
/// proper bullet/number markers and 1.6 line-height body text.
///
/// ```dart
/// MList(style: MListStyle.disc, items: [...])
/// ```
class MList extends StatelessWidget {
  const MList({
    super.key,
    required this.items,
    this.style = MListStyle.disc,
    this.startIndex = 1,
  });

  final List<MListItem> items;
  final MListStyle style;
  final int startIndex;

  @override
  Widget build(BuildContext context) {
    final body = Theme.of(context).textTheme.bodyMedium ?? const TextStyle();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < items.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (style != MListStyle.none)
                  Padding(
                    padding: const EdgeInsets.only(right: 10, top: 2),
                    child: Text(
                      style == MListStyle.disc ? '\u2022' : '${startIndex + i}.',
                      style: body.copyWith(color: MinimilistColors.text),
                    ),
                  ),
                Expanded(
                  child: items[i].child ??
                      Text(items[i].text, style: body),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Description list (`<dl>/<dt>/<dd>`) — bold term followed by indented
/// description, the classic documentation pattern.
class MDescriptionList extends StatelessWidget {
  const MDescriptionList({super.key, required this.entries});

  final Map<String, String> entries;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final e in entries.entries)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e.key,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 2),
                  child: Text(
                    e.value,
                    style: const TextStyle(color: MinimilistColors.text),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
