import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/sizing.dart';

/// A table cell descriptor for [MTable].
class MCell {
  const MCell(this.text, {this.align = TextAlign.left, this.bold = false});

  final String text;
  final TextAlign align;
  final bool bold;
}

/// A row of cells.
typedef MRowCells = List<MCell>;

/// Milligram-styled table (`<table>`): bottom-bordered header, thin row
/// dividers, padded cells, fully horizontal-scroll safe.
///
/// ```dart
/// MTable(
///   headers: const ['Name', 'Age', 'City'],
///   rows: const [
///     [MCell('Ada'), MCell('36'), MCell('London')],
///     [MCell('Grace'), MCell('85'), MCell('NYC')],
///   ],
/// )
/// ```
class MTable extends StatelessWidget {
  const MTable({
    super.key,
    required this.headers,
    required this.rows,
    this.columnWidths,
    this.striped = false,
    this.onTapRow,
  });

  final List<String> headers;
  final List<MRowCells> rows;

  /// Flex factors per column; defaults to equal widths.
  final List<int>? columnWidths;

  /// Alternating very-light background on even rows.
  final bool striped;

  final ValueChanged<int>? onTapRow;

  @override
  Widget build(BuildContext context) {
    final flex = columnWidths ?? List.filled(headers.length, 1);

    List<Widget> headerCells() {
      return [
        for (var i = 0; i < headers.length; i++)
          Expanded(
            flex: i < flex.length ? flex[i] : 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Text(
                headers[i],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: MinimilistColors.textDark,
                ),
              ),
            ),
          ),
      ];
    }

    List<Widget> bodyCells(MRowCells cells) {
      return [
        for (var i = 0; i < cells.length; i++)
          Expanded(
            flex: i < flex.length ? flex[i] : 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: _cellText(cells[i]),
            ),
          ),
      ];
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.sizeOf(context).width * 0.9,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header row with the classic bottom border.
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: MinimilistColors.border),
                ),
              ),
              child: IntrinsicHeight(
                child: Row(children: headerCells()),
              ),
            ),
            // Body rows.
            for (var r = 0; r < rows.length; r++)
              Container(
                color: striped && r.isEven
                    ? MinimilistColors.surface
                    : Colors.transparent,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: r == rows.length - 1
                          ? Colors.transparent
                          : MinimilistColors.borderLight,
                    ),
                  ),
                ),
                child: InkWell(
                  onTap: onTapRow == null ? null : () => onTapRow!(r),
                  child: IntrinsicHeight(
                    child: Row(children: bodyCells(rows[r])),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _cellText(MCell cell) => Text(
        cell.text,
        textAlign: cell.align,
        style: TextStyle(
          fontSize: MinimilistSpacing.rem + 5,
          fontWeight: cell.bold ? FontWeight.bold : FontWeight.normal,
          color: MinimilistColors.text,
        ),
      );
}
