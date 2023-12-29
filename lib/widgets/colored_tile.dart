import 'package:flutter/material.dart';

class ColoredTile extends StatelessWidget {
  final int index;
  final Widget title;
  final Widget subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const ColoredTile({
    Key? key,
    required this.index,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    final Color tileColor = index.isOdd ? oddItemColor : evenItemColor;

    return ListTile(
      tileColor: tileColor,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
