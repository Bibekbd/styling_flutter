import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/sizing.dart';

/// A form label above an input — Milligram `label` (bold, 1.6rem) with
/// the classic 0.5rem bottom margin.
class MLabel extends StatelessWidget {
  const MLabel(this.text, {super.key, this.required = false});

  final String text;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          if (required)
            const Text(' *',
                style: TextStyle(color: MinimilistColors.error)),
        ],
      ),
    );
  }
}

/// Wraps a control with a label + optional helper/error text, mirroring
/// Milligram's `<label>` + input structure.
class MFormField extends StatelessWidget {
  const MFormField({
    super.key,
    required this.label,
    required this.child,
    this.helperText,
    this.errorText,
    this.required = false,
  });

  final String label;
  final Widget child;
  final String? helperText;
  final String? errorText;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MinimilistSpacing.fieldMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MLabel(label, required: required),
          child,
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                errorText!,
                style: const TextStyle(
                  color: MinimilistColors.error,
                  fontSize: 13,
                ),
              ),
            )
          else if (helperText != null)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                helperText!,
                style: const TextStyle(
                  color: MinimilistColors.textLight,
                  fontSize: 13,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Milligram-styled single-line text field.
class MTextField extends StatelessWidget {
  const MTextField({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines = 1,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.prefixIcon,
    this.suffix,
    this.required = false,
    this.autofocus = false,
    this.textInputAction,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool enabled;
  final IconData? prefixIcon;
  final Widget? suffix;
  final bool required;
  final bool autofocus;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    final field = TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: obscureText ? 1 : maxLines,
      enabled: enabled,
      autofocus: autofocus,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 20) : null,
        suffixIcon: suffix != null
            ? IconTheme(data: const IconThemeData(size: 20), child: suffix!)
            : null,
        errorText: null, // handled by MFormField wrapper below
      ),
    );

    if (label == null) return field;
    return MFormField(
      label: label!,
      required: required,
      helperText: helperText,
      errorText: errorText,
      child: field,
    );
  }
}

/// Multi-line textarea (`<textarea>`).
class MTextArea extends StatelessWidget {
  const MTextArea({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.rows = 4,
    this.onChanged,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final int rows;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final field = TextField(
      controller: controller,
      maxLines: rows,
      onChanged: onChanged,
      decoration: InputDecoration(hintText: hintText),
    );
    if (label == null) return field;
    return MFormField(label: label!, child: field);
  }
}

/// Dropdown styled like Milligram's `select` (bordered box, chevron).
class MDropdown<T> extends StatelessWidget {
  const MDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.label,
    this.hint,
  });

  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final field = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MinimilistSpacing.borderRadius),
        border: Border.all(color: MinimilistColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          value: value,
          hint: hint != null ? Text(hint!) : null,
          onChanged: onChanged,
          items: items,
          dropdownColor: Theme.of(context).colorScheme.surface,
          style: const TextStyle(fontSize: 15, color: MinimilistColors.text),
        ),
      ),
    );
    if (label == null) return field;
    return MFormField(label: label!, child: field);
  }
}

/// Checkbox with Milligram-style inline label ("I agree to..." pattern).
class MCheckboxField extends StatelessWidget {
  const MCheckboxField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged == null ? null : () => onChanged!(!value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged == null ? null : (v) => onChanged!(v ?? false),
            ),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Radio group item with inline label.
class MRadioField<T> extends StatelessWidget {
  const MRadioField({
    super.key,
    required this.groupValue,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  final T groupValue;
  final T value;
  final ValueChanged<T>? onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged == null ? null : () => onChanged!(value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Radio<T>(
              groupValue: groupValue,
              value: value,
              onChanged: onChanged,
            ),
            Expanded(child: Text(label, style: const TextStyle(fontSize: 15))),
          ],
        ),
      ),
    );
  }
}

/// Switch row — "Feature enabled" pattern.
class MSwitchField extends StatelessWidget {
  const MSwitchField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.subtitle,
  });

  final String label;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: Switch(value: value, onChanged: onChanged),
      contentPadding: EdgeInsets.zero,
    );
  }
}

/// A labelled slider — Milligram styles bare `input[type=range]` tracks;
/// here we pair the label above and value at the end.
class MSliderField extends StatelessWidget {
  const MSliderField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 1,
    this.divisions,
    this.valueLabel,
  });

  final String label;
  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final String? valueLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MinimilistSpacing.fieldMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MLabel(label),
              if (valueLabel != null)
                Text(valueLabel!,
                    style: const TextStyle(color: MinimilistColors.textLight)),
            ],
          ),
          Slider(
            value: value.clamp(min, max),
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
