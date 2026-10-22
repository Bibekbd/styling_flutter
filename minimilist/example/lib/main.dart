import 'package:flutter/material.dart';
import 'package:minimilist/minimilist.dart';

void main() => runApp(const MinimilistDemoApp());

class MinimilistDemoApp extends StatelessWidget {
  const MinimilistDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'minimilist demo',
      debugShowCheckedModeBanner: false,
      theme: MinimilistTheme.light(),
      darkTheme: MinimilistTheme.dark(),
      home: const DemoHome(),
    );
  }
}

class DemoHome extends StatefulWidget {
  const DemoHome({super.key});

  @override
  State<DemoHome> createState() => _DemoHomeState();
}

class _DemoHomeState extends State<DemoHome> {
  final _name = TextEditingController();
  bool _checked = true;
  int _radio = 0;
  double _slider = 0.5;
  bool _switch = true;
  String? _dropdown;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MAppBar(title: 'minimilist'),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          MContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const MHeading('Milligram, in Flutter',
                    level: MHeadingLevel.h2),
                const MText(
                  'minimilist ports the entire Milligram design system — '
                  'typography, grid, forms, buttons and tables — into '
                  'Flutter widgets.',
                ),
                const MSpacer(),
                // Buttons
                MButtonGroup(children: [
                  MButton(
                    label: 'Primary',
                    onPressed: () => MSnackBar.show(context,
                        message: 'You tapped Primary!'),
                  ),
                  MButton(
                    label: 'Outlined',
                    variant: MButtonVariant.outlined,
                    onPressed: () {},
                  ),
                  MButton(label: 'Disabled', onPressed: null),
                ]),
                const MSpacer(),
                const MDivider(),
                // Grid demo
                const MHeading('Grid', level: MHeadingLevel.h4),
                MRow(children: const [
                  MColumn(
                      width: MWidth.oneThird,
                      child: _Box(color: Color(0xFFF4F5F6), label: 'one-third')),
                  MColumn(
                      width: MWidth.twoThirds,
                      child: _Box(color: Color(0xFFEAF6FF), label: 'two-thirds')),
                ]),
                const SizedBox(height: 12),
                MRow(children: const [
                  MColumn(
                      width: MWidth.oneFourth, child: _Box(label: '1/4')),
                  MColumn(
                      width: MWidth.oneHalf, child: _Box(label: '1/2')),
                  MColumn(
                      width: MWidth.oneFourth, child: _Box(label: '1/4')),
                ]),
                const MDivider(),
                // Form
                const MHeading('Form', level: MHeadingLevel.h4),
                MTextField(
                  controller: _name,
                  label: 'Name',
                  hintText: 'Ada Lovelace',
                  required: true,
                  prefixIcon: Icons.person_outline,
                ),
                MTextField(
                  label: 'Email',
                  hintText: 'ada@example.com',
                  keyboardType: TextInputType.emailAddress,
                  helperText: "We'll never share your email.",
                ),
                MDropdown<String>(
                  label: 'Country',
                  hint: 'Select…',
                  value: _dropdown,
                  onChanged: (v) => setState(() => _dropdown = v),
                  items: const [
                    DropdownMenuItem(value: 'uk', child: Text('United Kingdom')),
                    DropdownMenuItem(value: 'us', child: Text('United States')),
                    DropdownMenuItem(value: 'in', child: Text('India')),
                  ],
                ),
                MCheckboxField(
                  label: 'I agree to the terms of service',
                  value: _checked,
                  onChanged: (v) => setState(() => _checked = v),
                ),
                MRadioField(label: 'Newsletter: daily', groupValue: _radio, value: 0,
                    onChanged: (v) => setState(() => _radio = v)),
                MRadioField(label: 'Newsletter: weekly', groupValue: _radio, value: 1,
                    onChanged: (v) => setState(() => _radio = v)),
                MSliderField(
                  label: 'Volume',
                  value: _slider,
                  valueLabel: '${(_slider * 100).round()}%',
                  onChanged: (v) => setState(() => _slider = v),
                ),
                MSwitchField(
                  label: 'Notifications',
                  subtitle: 'Receive an alert when something happens',
                  value: _switch,
                  onChanged: (v) => setState(() => _switch = v),
                ),
                const MSpacer(),
                MButton(
                  label: 'Submit',
                  expand: true,
                  onPressed: () async {
                    final ok = await MDialog.confirm(
                      context,
                      title: 'Send form?',
                      message:
                          'Your name: ${_name.text.isEmpty ? 'stranger' : _name.text}',
                      confirmLabel: 'Send',
                    );
                    if (ok == true && context.mounted) {
                      MSnackBar.show(context, message: 'Form sent');
                    }
                  },
                ),
                const MDivider(),
                // Card + badges + blockquote + alert
                MCard(
                  title: 'Pro plan',
                  subtitle: 'Billed annually',
                  trailing: const MBadge('POPULAR'),
                  onTap: () {},
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MText('Everything in Free, plus priority support, '
                          'unlimited projects and custom domains.'),
                      MHalfSpacer(),
                      MList(items: [
                        MListItem('Unlimited projects'),
                        MListItem('Custom domains'),
                        MListItem('Priority support'),
                      ]),
                    ],
                  ),
                ),
                const MBlockquote(
                  text: 'Simplicity is the ultimate sophistication.',
                  cite: '— Leonardo da Vinci',
                ),
                const MAlert(
                  tone: MTone.success,
                  icon: Icons.check_circle_outline,
                  title: 'Saved',
                  message: 'Your profile has been updated.',
                ),
                const MDivider(),
                // Table
                const MHeading('Table', level: MHeadingLevel.h4),
                MTable(
                  headers: const ['Name', 'Role', 'Status'],
                  rows: const [
                    [MCell('Ada', bold: true), MCell('Engineer'), MCell('Active')],
                    [MCell('Grace'), MCell('Rear Admiral'), MCell('Retired')],
                    [MCell('Alan'), MCell('Cryptographer'), MCell('Active')],
                  ],
                ),
                const MSpacer(),
                Center(
                  child: MLink(
                    'Built with minimilist · inspired by milligram',
                    onTap: () {},
                  ),
                ),
                const MSpacer(40),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: MBottomNav(
        currentIndex: 0,
        onTap: (_) {},
        items: const [
          MNavItem(label: 'Home', icon: Icons.home_outlined),
          MNavItem(label: 'Grid', icon: Icons.grid_view_outlined),
          MNavItem(label: 'Form', icon: Icons.edit_note_outlined),
          MNavItem(label: 'About', icon: Icons.info_outline),
        ],
      ),
    );
  }
}

class _Box extends StatelessWidget {
  const _Box({required this.label, this.color = const Color(0xFFF4F5F6)});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(MinimilistSpacing.borderRadius),
        border: Border.all(color: MinimilistColors.border),
      ),
      child: Text(label, style: const TextStyle(fontSize: 13)),
    );
  }
}
