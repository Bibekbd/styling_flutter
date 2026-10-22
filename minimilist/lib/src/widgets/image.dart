import 'package:flutter/material.dart';

import '../theme/sizing.dart';

/// Rounded image — mirrors Milligram's `.image-rounded` (4px radius) and
/// full-radius circle avatar pattern.
class MImage extends StatelessWidget {
  const MImage(
    this.image, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.rounded = true,
    this.circle = false,
  });

  /// Any ImageProvider (NetworkImage, AssetImage, FileImage...).
  final ImageProvider image;
  final double? width;
  final double? height;
  final BoxFit fit;

  /// Apply Milligram's 4px border radius.
  final bool rounded;

  /// Circular crop (like a profile avatar).
  final bool circle;

  @override
  Widget build(BuildContext context) {
    final img = Image(image: image, width: width, height: height, fit: fit);
    if (circle) {
      final size = width ?? height ?? 80.0;
      return ClipOval(child: SizedBox(width: size, height: size, child: img));
    }
    if (!rounded) return img;
    return ClipRRect(
      borderRadius: BorderRadius.circular(MinimilistSpacing.borderRadius),
      child: img,
    );
  }
}
