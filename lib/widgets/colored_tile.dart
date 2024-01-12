import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/utils/shared_ui_constants.dart';

class ColoredTile extends StatelessWidget {
  final int index;
  final Widget title;
  final Widget subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final IconData? icon;

  const ColoredTile({
    super.key,
    required this.index,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
    this.icon = Icons.music_note,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    final Color tileColor = index.isOdd ? oddItemColor : evenItemColor;

    return ListTile(
      tileColor: tileColor,
      leading: Container(
        width: 48.0,
        height: 48.0,
        decoration: BoxDecoration(
          color: tileColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(SMALL_RADIUS),
        ),
        child: Center(
          child: Icon(
            icon,
            color: tileColor.withOpacity(0.5),
          ),
        ),
      ),
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
