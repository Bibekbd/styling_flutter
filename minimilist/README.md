# minimilist

> **A minimalist Flutter UI styling package inspired by [Milligram](https://github.com/milligram/milligram)** — the malleable, classless HTML/CSS framework. `minimilist` brings Milligram's entire design language (typography scale, 12-column grid, forms, buttons, tables and subtle greys) to Flutter as a complete theme **and** ready-to-use widgets.

![Flutter](https://img.shields.io/badge/Flutter-3.x-027DFB)
![License](https://img.shields.io/badge/license-MIT-green)

**Repository:** <https://github.com/<your-username>/minimilist> · **Issues:** <https://github.com/<your-username>/minimilist/issues> · **Design inspiration:** [milligram/milligram](https://github.com/milligram/milligram)

---

## ✨ Why minimilist?

[Milligram](https://github.com/milligram/milligram) gives web developers a clean, minimal starting point with almost no classes to learn. `minimilist` does the same for Flutter:

- 🎨 **Full app theming in one line** — `MinimilistTheme.light()` restyles every Material widget to look like a Milligram page.
- 🧱 **Widget port of every Milligram component** — headings, buttons, forms, grid, tables, lists, blockquotes, code blocks, dividers…
- 📱 **Responsive by default** — the grid collapses exactly like Milligram's media queries (400 / 550 / 800 / 1000 px breakpoints).
- 🌗 **Light + dark themes** out of the box.
- 🪶 **Zero dependencies** beyond the Flutter SDK.

## 🚀 Installation

### Install from GitHub

`minimilist` is distributed as a Flutter package on GitHub. Add it under `dependencies:` in your app's `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter

  minimilist:
    git:
      url: https://github.com/<your-username>/minimilist.git
      ref: main          # branch, tag (e.g. v1.0.0) or commit hash — optional
```

If the package lives inside a monorepo sub-folder, point at it with `path`:

```yaml
dependencies:
  minimilist:
    git:
      url: https://github.com/<your-username>/minimilist.git
      ref: main
      path: packages/minimilist   # sub-directory that contains pubspec.yaml
```

Then fetch the dependency:

```bash
flutter pub get
```

### Alternative install methods

**Local path** (while developing, or vendoring the repo):

```yaml
dependencies:
  minimilist:
    path: ../minimilist        # folder containing this README/pubspec.yaml
```

**Pub.dev** (once published):

```yaml
dependencies:
  minimilist: ^1.0.0
```

Or add it with the CLI:

```bash
flutter pub add minimilist
# from GitHub directly:
dart pub add minimilist:'{"git":{"url":"https://github.com/<your-username>/minimilist.git","ref":"main"}}'
```

### Import

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

### Complete app — drop-in starter (`main.dart`)

```dart
import 'package:flutter/material.dart';
import 'package:minimilist/minimilist.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minimilist Demo',
      theme: MinimilistTheme.light(),
      darkTheme: MinimilistTheme.dark(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final email = TextEditingController();
  bool agreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MAppBar(title: Text('minimilist')),
      body: MContainer(
        child: ListView(
          padding: const EdgeInsets.all(MinimilistSpacing.gridGutter),
          children: [
            const MHeading('Hello, world', level: MHeadingLevel.h1),
            const MText('A Milligram-style UI, in Flutter.'),
            const MSpacer(),
            MRow(children: const [
              MColumn(width: MWidth.oneHalf, child: MCard(title: 'Left', child: MText('one-half'))),
              MColumn(width: MWidth.oneHalf, child: MCard(title: 'Right', child: MText('one-half'))),
            ]),
            const MSpacer(),
            MTextField(controller: email, label: 'Email address', hintText: 'ada@example.com'),
            MCheckboxField(label: 'I agree to the terms', value: agreed, onChanged: (v) => setState(() => agreed = v)),
            const MHalfSpacer(),
            MButton(label: 'Send', onPressed: () => MSnackBar.show(context, message: 'Saved!')),
            MButton(label: 'Cancel', variant: MButtonVariant.outlined, onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
```

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

## 📸 Screenshots

Add screenshots of your example app here (drop images into `doc/screenshots/`):

```markdown
![Home screen](doc/screenshots/home.png)
![Forms](doc/screenshots/forms.png)
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

## 🙏 Acknowledgements

- Design system ported from [CoffeyCo's Milligram](https://github.com/milligram/milligram) (MIT licensed).
- Built with Flutter's Material theming APIs.
