import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/utils/shared_ui_constants.dart';

class CommonDropdownButton<T> extends StatelessWidget {
  final T? value;
  final ValueChanged<T?>? onChanged;
  final List<DropdownMenuItem<T>>? items;

  const CommonDropdownButton({
    super.key,
    this.value,
    this.onChanged,
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return DropdownButton2<T>(
      value: value,
      onChanged: (newValue) {
        onChanged!(newValue);
      },
      items: items,
      buttonStyleData: ButtonStyleData(
        width: 170,
        padding: const EdgeInsets.only(left: SMALL_GAP, right: SMALL_GAP),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(STANDARD_RADIUS),
        ),
      ),
      dropdownStyleData: DropdownStyleData(
        width: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(STANDARD_RADIUS),
          color: colorScheme.surfaceVariant,
        ),
      ),
    );
  }
}
