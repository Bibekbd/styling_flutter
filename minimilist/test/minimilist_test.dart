import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimilist/minimilist.dart';

Widget wrap(Widget child) => MaterialApp(
      theme: MinimilistTheme.light(),
      home: Scaffold(body: SingleChildScrollView(child: child)),
    );

void main() {
  testWidgets('MHeading renders with h1 size', (tester) async {
    await tester.pumpWidget(wrap(const MHeading('Hello')));
    expect(find.text('Hello'), findsOneWidget);
    final text = tester.widget<Text>(find.text('Hello'));
    expect(text.style?.fontSize, 40.0);
    expect(text.style?.fontWeight, FontWeight.w300);
  });

  testWidgets('MButton filled fires onPressed', (tester) async {
    var tapped = 0;
    await tester.pumpWidget(
      wrap(MButton(label: 'Tap me', onPressed: () => tapped++)),
    );
    await tester.tap(find.text('Tap me'));
    await tester.pump();
    expect(tapped, 1);
  });

  testWidgets('Disabled MButton does not fire', (tester) async {
    var tapped = 0;
    await tester.pumpWidget(wrap(MButton(label: 'Nope', onPressed: null)));
    await tester.tap(find.text('Nope'));
    await tester.pump();
    expect(tapped, 0);
  });

  testWidgets('busy MButton shows spinner and blocks taps', (tester) async {
    var tapped = 0;
    await tester.pumpWidget(wrap(MButton(
      label: 'Save',
      busy: true,
      onPressed: () => tapped++,
    )));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.tap(find.text('Save'));
    await tester.pump();
    expect(tapped, 0);
  });

  testWidgets('MTextField shows label and helper text', (tester) async {
    await tester.pumpWidget(wrap(const MTextField(
      label: 'Email',
      hintText: 'you@example.com',
      helperText: 'Never shared.',
    )));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Never shared.'), findsOneWidget);
  });

  testWidgets('MCheckboxField toggles', (tester) async {
    bool value = false;
    await tester.pumpWidget(wrap(StatefulBuilder(
      builder: (_, setState) => MCheckboxField(
        label: 'Agree',
        value: value,
        onChanged: (v) => setState(() => value = v),
      ),
    )));
    await tester.tap(find.text('Agree'));
    await tester.pump();
    expect(value, isTrue);
  });

  testWidgets('MRow lays columns side by side on wide screens',
      (tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(wrap(MRow(children: const [
      MColumn(width: MWidth.oneHalf, child: Text('A')),
      MColumn(width: MWidth.oneHalf, child: Text('B')),
    ])));

    final a = tester.getRect(find.text('A'));
    final b = tester.getRect(find.text('B'));
    expect(a.right, lessThan(b.left)); // horizontal layout
  });

  testWidgets('MTable renders headers and rows', (tester) async {
    await tester.pumpWidget(wrap(const MTable(
      headers: ['Name', 'Age'],
      rows: [
        [MCell('Ada'), MCell('36')],
      ],
    )));
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Ada'), findsOneWidget);
  });

  testWidgets('MBadge and MBlockquote render', (tester) async {
    await tester.pumpWidget(wrap(const Column(children: [
      MBadge('NEW'),
      MBlockquote(text: 'Quote me', cite: '— Me'),
    ])));
    expect(find.text('NEW'), findsOneWidget);
    expect(find.text('"Quote me"'), findsOneWidget);
  });

  testWidgets('MDivider has 1px height', (tester) async {
    await tester.pumpWidget(wrap(const MDivider()));
    final box = tester.getSize(find.byType(MDivider));
    expect(box.height, MinimilistSpacing.borderWidth);
  });

  test('theme exposes Milligram tokens', () {
    final theme = MinimilistTheme.light();
    expect(theme.colorScheme.primary, MinimilistColors.primary);
    expect(theme.scaffoldBackgroundColor, MinimilistColors.background);
    expect(theme.textTheme.bodyMedium?.fontSize, 15.0);
  });
}
