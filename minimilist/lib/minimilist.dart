/// minimilist
///
/// A minimalist Flutter UI styling package inspired by
/// [Milligram](https://github.com/milligram/milligram) — a minimalist
/// boilerplate for rapid development of fast, scalable websites.
///
/// It brings Milligram's design language (Roboto typography, generous
/// whitespace, 1rem borders, pill buttons, subtle greys and the classic
/// 12-column grid) to Flutter as a complete theme plus ready-to-use
/// widgets: buttons, forms, cards, tables, lists, blockquotes, grids
/// and more.
///
/// ```dart
/// MaterialApp(theme: MinimilistTheme.light())
/// ```
library minimilist;

// Core design tokens & theme
export 'src/theme/colors.dart';
export 'src/theme/typography.dart';
export 'src/theme/sizing.dart';
export 'src/theme/minimilist_theme.dart';

// Layout primitives (Milligram Grid)
export 'src/widgets/grid.dart';
export 'src/widgets/container.dart';
export 'src/widgets/row_spacer.dart';

// Typography widgets (Milligram Typography)
export 'src/widgets/typography.dart';

// Components (Milligram Nucleus)
export 'src/widgets/button.dart';
export 'src/widgets/form.dart';
export 'src/widgets/card.dart';
export 'src/widgets/table.dart';
export 'src/widgets/list.dart';
export 'src/widgets/blockquote.dart';
export 'src/widgets/divider.dart';
export 'src/widgets/image.dart';
export 'src/widgets/badge.dart';
export 'src/widgets/app_bar.dart';
export 'src/widgets/navigation.dart';
export 'src/widgets/snackbar.dart';
export 'src/widgets/dialog.dart';
