# minimilist

> **A minimalist Flutter UI styling package inspired by [Milligram](https://github.com/milligram/milligram)** — the malleable, classless HTML/CSS framework. `minimilist` brings Milligram's entire design language (typography scale, 12-column grid, forms, buttons, tables and subtle greys) to Flutter as a complete theme **and** ready-to-use widgets.

![Flutter](https://img.shields.io/badge/Flutter-3.x-027DFB)
![License](https://img.shields.io/badge/license-MIT-green)

---

## ✨ Why minimilist?

[Milligram](https://github.com/milligram/milligram) gives web developers a clean, minimal starting point with almost no classes to learn. `minimilist` does the same for Flutter:

- 🎨 **Full app theming in one line** — `MinimilistTheme.light()` restyles every Material widget to look like a Milligram page.
- 🧱 **Widget port of every Milligram component** — headings, buttons, forms, grid, tables, lists, blockquotes, code blocks, dividers…
- 📱 **Responsive by default** — the grid collapses exactly like Milligram's media queries (400 / 550 / 800 / 1000 px breakpoints).
- 🌗 **Light + dark themes** out of the box.
- 🪶 **Zero dependencies** beyond the Flutter SDK.

## 🚀 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  minimilist:
    git:
      url: https://github.com/milligram/milligram.git # or a path/hosted pub package named "minimilist"
```

Then import:

```dart
import 'package:minimilist/minimilist.dart';
```

## 🎨 Theme your whole app

```dart
MaterialApp(
  theme: MinimilistTheme.light(),          // Milligram look & feel
  darkTheme: MinimilistTheme.dark(),       // dark variant
  home: const MyHome(),
);
```

That alone re-skins `AppBar`, buttons, text fields, checkboxes, switches, sliders, cards, dialogs, snackbars, chips and typography to match Milligram: white canvas, `#606c76` body text, `#d8197d` accent, 1px `#ddd` borders, 4px radii and light-weight Roboto headings.

Prefer another accent? `MinimilistTheme.light(primaryColor: Colors.indigo)`.

## 🧩 Widgets at a glance

| Web (Milligram)            | Flutter (minimilist)                                   |
|----------------------------|--------------------------------------------------------|
| `<h1>–<h6>`                | `MHeading('Title', level: MHeadingLevel.h2)`           |
| `<p>`                      | `MText(...)`, `MBold`, `MItalic`, `MLink`              |
| `<code>` / `<pre>`         | `MCode('var x = 1;')` / `MPreBlock(source)`            |
| `.container`               | `MContainer(child: ...)`                               |
| `.row` / `.column`         | `MRow` + `MColumn(width: MWidth.twoThirds)`            |
| `.button` / outline        | `MButton(label:, variant: MButtonVariant.outlined)`    |
| `label + input`            | `MTextField(label:, hintText:, helperText:)`           |
| `select`                   | `MDropdown`                                            |
| checkbox / radio / range   | `MCheckboxField`, `MRadioField`, `MSliderField`, `MSwitchField` |
| `table`                    | `MTable(headers:, rows:)`                              |
| `ul / ol / dl`             | `MList`, `MDescriptionList`                            |
| `blockquote`               | `MBlockquote(text:, cite:)`                            |
| `hr`                       | `MDivider`                                             |
| images                     | `MImage` (rounded / circular)                          |
| navigation                 | `MNavBar`, `MBottomNav`, `MAppBar`                     |
| feedback                   | `MBadge`, `MAlert`, `MSnackBar.show`, `MDialog.confirm`|
| spacing rhythm             | `MSpacer`, `MHalfSpacer`                               |

## 📖 Usage examples

### Typography

```dart
const MHeading('Hello, world', level: MHeadingLevel.h1)
const MText('Body copy at 1.5rem with 1.6 line-height.')
MLink('Read more', onTap: openArticle)
const MCode('flutter run')
```

### Buttons

```dart
MButton(label: 'Send', onPressed: submit)
MButton(label: 'Cancel', variant: MButtonVariant.outlined, onPressed: reset)
MButton(label: 'Saving…', busy: true, onPressed: submit) // spinner + blocked taps
```

### The 12-column grid

```dart
MRow(children: const [
  MColumn(width: MWidth.oneThird, child: Text('one-third')),
  MColumn(width: MWidth.twoThirds, child: Text('two-thirds')),
])
```

Below 550px the columns stack full-width, just like Milligram on mobile.

### Forms

```dart
final email = TextEditingController();

MTextField(
  controller: email,
  label: 'Email address',
  hintText: 'ada@example.com',
  helperText: "We'll never share your email.",
  required: true,
)

MCheckboxField(label: 'I agree to the terms', value: agreed, onChanged: toggle)
MDropdown<String>(label: 'Country', value: country, items: countries, onChanged: pick)
```

### Tables, cards, quotes

```dart
MTable(
  headers: const ['Name', 'Role'],
  rows: const [[MCell('Ada', bold: true), MCell('Engineer')]],
)

MCard(title: 'Pro plan', trailing: const MBadge('POPULAR'), child: ...)

const MBlockquote(
  text: 'Simplicity is the ultimate sophistication.',
  cite: '— Leonardo da Vinci',
)
```

### Feedback

```dart
MSnackBar.show(context, message: 'Saved!', actionLabel: 'Undo', onAction: undo);

final ok = await MDialog.confirm(
  context,
  title: 'Delete post?',
  message: 'This cannot be undone.',
  confirmLabel: 'Delete',
  destructive: true,
);
```

## 🧪 Example app

A full showcase lives in [`example/`](example/):

```bash
cd example
flutter pub get
flutter run
```

It demonstrates every widget — hero headings, button variants, the responsive grid, a complete form, cards, badges, alerts, blockquotes and a table — with the theme applied globally.

## 🎯 Design tokens

All raw values from Milligram's `_Variables.scss` are exposed for custom work:

```dart
MinimilistColors.primary     // #D8197D
MinimilistColors.text        // #606C76
MinimilistColors.border      // #DDDDDD
MinimilistSpacing.borderRadius   // 4.0
MinimilistSpacing.containerMaxWidth // 960.0
MinimilistTypography.baseFontSize   // 15.0
MinimilistBreakpoint.of(context)    // phone/tablet/desktop detection
```

## 📄 License

MIT — same spirit (and source of inspiration) as [Milligram](https://github.com/milligram/milligram/blob/master/LICENSE).
