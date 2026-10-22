import 'package:flutter/material.dart';

import 'colors.dart';
import 'sizing.dart';
import 'typography.dart';

/// A complete [ThemeData] factory that restyles Flutter's Material widgets
/// to match the Milligram look: white canvas, #606c76 text, 1px #ddd
/// borders, 4px radii, pink accent and light-weight headings.
///
/// Usage:
/// ```dart
/// MaterialApp(
///   theme: MinimilistTheme.light(),
///   darkTheme: MinimilistTheme.dark(),
///   home: const MyHome(),
/// )
/// ```
class MinimilistTheme {
  MinimilistTheme._();

  static ThemeData light({Color? primaryColor}) {
    final accent = primaryColor ?? MinimilistColors.primary;
    final scheme = ColorScheme.fromSeed(seedColor: accent).copyWith(
      primary: accent,
      onPrimary: Colors.white,
      secondary: MinimilistColors.secondary,
      surface: MinimilistColors.background,
      onSurface: MinimilistColors.text,
      error: MinimilistColors.error,
      outline: MinimilistColors.border,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
      scaffoldBackgroundColor: MinimilistColors.background,
      canvasColor: MinimilistColors.background,
      fontFamily: MinimilistTypography.fontFamily,
      textTheme: MinimilistTypography.textTheme(),
      dividerTheme: const DividerThemeData(
        color: MinimilistColors.border,
        thickness: MinimilistSpacing.borderWidth,
        space: MinimilistSpacing.blockSpacing,
      ),
      cardTheme: CardThemeData(
        color: MinimilistColors.background,
        elevation: 0,
        margin: const EdgeInsets.only(bottom: MinimilistSpacing.blockSpacing),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MinimilistSpacing.borderRadius),
          side: const BorderSide(color: MinimilistColors.border),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: MinimilistColors.background,
        foregroundColor: MinimilistColors.textDark,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w300,
          color: MinimilistColors.textDark,
        ),
        iconTheme: const IconThemeData(color: MinimilistColors.text),
        scrolledUnderElevation: 0,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(MinimilistSpacing.borderWidth),
          child: ColoredBox(color: MinimilistColors.border),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: Colors.white,
          disabledBackgroundColor: MinimilistColors.placeholder,
          elevation: 0,
          minimumSize: const Size(0, MinimilistSpacing.controlHeight - 8),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 11),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MinimilistSpacing.buttonRadius),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: accent,
          side: const BorderSide(color: accent),
          minimumSize: const Size(0, MinimilistSpacing.controlHeight - 8),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 11),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MinimilistSpacing.buttonRadius),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accent,
          textStyle: const TextStyle(fontSize: 15, height: 1.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MinimilistSpacing.buttonRadius),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        filled: false,
        hintStyle: const TextStyle(color: MinimilistColors.placeholder),
        labelStyle: const TextStyle(color: MinimilistColors.textLight),
        floatingLabelStyle: TextStyle(color: accent),
        enabledBorder: _inputBorder(MinimilistColors.border),
        focusedBorder: _inputBorder(accent, width: 1.5),
        errorBorder: _inputBorder(MinimilistColors.error),
        focusedErrorBorder: _inputBorder(MinimilistColors.error, width: 1.5),
        border: _inputBorder(MinimilistColors.border),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        side: const BorderSide(color: MinimilistColors.placeholder, width: 1.5),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return accent;
          return Colors.transparent;
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return accent;
          return MinimilistColors.placeholder;
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return Colors.white;
          return MinimilistColors.background;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return accent;
          return MinimilistColors.placeholder;
        }),
        trackOutlineColor:
            const WidgetStatePropertyAll(Colors.transparent),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: accent,
        inactiveTrackColor: MinimilistColors.border,
        thumbColor: accent,
        overlayColor: accent.withValues(alpha: 0.15),
        trackHeight: 3,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: accent,
        linearTrackColor: MinimilistColors.border,
        circularTrackColor: MinimilistColors.border,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: MinimilistColors.surface,
        selectedColor: accent,
        side: const BorderSide(color: MinimilistColors.border),
        labelStyle: const TextStyle(
          fontSize: 13,
          color: MinimilistColors.text,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MinimilistSpacing.borderRadius),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: MinimilistColors.textDark,
        contentTextStyle: const TextStyle(color: Colors.white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MinimilistSpacing.borderRadius),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: MinimilistColors.background,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MinimilistSpacing.borderRadius),
          side: const BorderSide(color: MinimilistColors.border),
        ),
        titleTextStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w300,
          color: MinimilistColors.textDark,
        ),
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: MinimilistColors.textLight,
        textColor: MinimilistColors.text,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: MinimilistColors.textDark,
          borderRadius: BorderRadius.circular(MinimilistSpacing.borderRadius),
        ),
        textStyle: const TextStyle(color: Colors.white, fontSize: 13),
      ),
      tabBarTheme: const TabBarThemeData(
        labelColor: MinimilistColors.textDark,
        unselectedLabelColor: MinimilistColors.textLight,
        indicatorColor: MinimilistColors.primary,
        dividerColor: MinimilistColors.border,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: MinimilistColors.background,
        indicatorColor: accent.withValues(alpha: 0.1),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 12, color: MinimilistColors.text),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? accent : MinimilistColors.textLight,
          );
        }),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: MinimilistColors.background,
      ),
    ).copyWith(
      // ignore: deprecated_member_use
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  static ThemeData dark({Color? primaryColor}) {
    final base = light(primaryColor: primaryColor);
    final accent = primaryColor ?? MinimilistColors.primary;
    final scheme = ColorScheme.fromSeed(
      seedColor: accent,
      brightness: Brightness.dark,
    ).copyWith(
      primary: accent,
      surface: MinimilistColors.darkSurface,
      onSurface: MinimilistColors.darkText,
      outline: MinimilistColors.darkBorder,
    );

    return base.copyWith(
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: MinimilistColors.darkBackground,
      canvasColor: MinimilistColors.darkBackground,
      textTheme: MinimilistTypography.darkTextTheme(),
      dividerTheme: const DividerThemeData(
        color: MinimilistColors.darkBorder,
        thickness: MinimilistSpacing.borderWidth,
        space: MinimilistSpacing.blockSpacing,
      ),
      cardTheme: (base.cardTheme ?? const CardThemeData()).copyWith(
        color: MinimilistColors.darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MinimilistSpacing.borderRadius),
          side: const BorderSide(color: MinimilistColors.darkBorder),
        ),
      ),
      appBarTheme: (base.appBarTheme).copyWith(
        backgroundColor: MinimilistColors.darkBackground,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(MinimilistSpacing.borderWidth),
          child: ColoredBox(color: MinimilistColors.darkBorder),
        ),
      ),
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        enabledBorder: _inputBorder(MinimilistColors.darkBorder),
        border: _inputBorder(MinimilistColors.darkBorder),
      ),
    );
  }

  static OutlineInputBorder _inputBorder(Color color, {double width = 1.0}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(MinimilistSpacing.borderRadius),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
