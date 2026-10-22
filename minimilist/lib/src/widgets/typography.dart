import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/sizing.dart';

/// Headline levels mirroring HTML `<h1>`–`<h6>` as styled by Milligram's
/// `_Typography.scss`: light weight (300), dark #313131 color and a
/// descending scale 4.0 / 3.6 / 3.0 / 2.4 / 1.8 / 1.6 rem.
enum MHeadingLevel { h1, h2, h3, h4, h5, h6 }

/// A Milligram-styled heading widget.
///
/// ```dart
/// MHeading('Hello world', level: MHeadingLevel.h2)
/// ```
class MHeading extends StatelessWidget {
  const MHeading(
    this.data, {
    super.key,
    this.level = MHeadingLevel.h1,
    this.align,
    this.style,
  });

  final String data;
  final MHeadingLevel level;
  final TextAlign? align;
  final TextStyle? style;

  double get _size => switch (level) {
        MHeadingLevel.h1 => 40.0,
        MHeadingLevel.h2 => 36.0,
        MHeadingLevel.h3 => 30.0,
        MHeadingLevel.h4 => 24.0,
        MHeadingLevel.h5 => 18.0,
        MHeadingLevel.h6 => 16.0,
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final base = switch (level) {
      MHeadingLevel.h1 => theme.displayLarge,
      MHeadingLevel.h2 => theme.displayMedium,
      MHeadingLevel.h3 => theme.displaySmall,
      MHeadingLevel.h4 => theme.headlineMedium,
      MHeadingLevel.h5 => theme.headlineSmall,
      MHeadingLevel.h6 => theme.titleLarge,
    };
    return Text(
      data,
      textAlign: align,
      style: (base ?? const TextStyle()).copyWith(fontSize: _size).merge(style),
    );
  }
}

/// Milligram-styled paragraph — 1.5rem body text with 1.6 line-height.
class MText extends StatelessWidget {
  const MText(
    this.data, {
    super.key,
    this.align,
    this.style,
    this.muted = false,
  });

  final String data;
  final TextAlign? align;
  final TextStyle? style;

  /// Renders in the lighter grey used for secondary copy.
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).textTheme.bodyMedium ?? const TextStyle();
    return Text(
      data,
      textAlign: align,
      style: base
          .copyWith(color: muted ? MinimilistColors.textLight : null)
          .merge(style),
    );
  }
}

/// Inline bold (`<strong>`) helper.
class MBold extends StatelessWidget {
  const MBold(this.data, {super.key, this.style});
  final String data;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) => Text(
        data,
        style: (Theme.of(context).textTheme.bodyMedium ?? const TextStyle())
            .copyWith(fontWeight: FontWeight.bold)
            .merge(style),
      );
}

/// Inline italic (`<em>`) helper.
class MItalic extends StatelessWidget {
  const MItalic(this.data, {super.key, this.style});
  final String data;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) => Text(
        data,
        style: (Theme.of(context).textTheme.bodyMedium ?? const TextStyle())
            .copyWith(fontStyle: FontStyle.italic)
            .merge(style),
      );
}

/// A tappable link styled like Milligram anchors (#d8197d, no underline
/// until hover/press).
class MLink extends StatelessWidget {
  const MLink(
    this.text, {
    super.key,
    this.onTap,
    this.color,
    this.decoration = TextDecoration.none,
  });

  final String text;
  final VoidCallback? onTap;
  final Color? color;
  final TextDecoration decoration;

  @override
  Widget build(BuildContext context) {
    final accent = color ?? Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: onTap,
      child: Text.rich(
        TextSpan(
          text: text,
          style: (Theme.of(context).textTheme.bodyMedium ?? const TextStyle())
              .copyWith(color: accent, decoration: decoration),
          recognizer: TapGestureRecognizer()..onTap = onTap,
        ),
      ),
    );
  }
}

/// Inline code chip — Milligram `code` styling: #e0225e text on #f4f5f6
/// background with a 1px border and 4px radius.
class MCode extends StatelessWidget {
  const MCode(this.code, {super.key, this.multiline = false});

  final String code;
  final bool multiline;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: MinimilistColors.surface,
        borderRadius: BorderRadius.circular(MinimilistSpacing.borderRadius),
        border: Border.all(color: MinimilistColors.border),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 13,
          color: Color(0xFFE0225E),
        ),
      ),
    );
  }
}

/// A scrollable multi-line code block (`<pre><code>`): full-width panel,
/// padded 1rem, horizontally scrollable like Milligram's `pre`.
class MPreBlock extends StatelessWidget {
  const MPreBlock(this.code, {super.key, this.maxHeight = 240});

  final String code;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(maxHeight: maxHeight),
        padding: const EdgeInsets.all(MinimilistSpacing.rem),
        decoration: BoxDecoration(
          color: MinimilistColors.surface,
          borderRadius: BorderRadius.circular(MinimilistSpacing.borderRadius),
          border: Border.all(color: MinimilistColors.border),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              height: 1.6,
              color: MinimilistColors.text,
            ),
          ),
        ),
      ),
    );
  }
}
