import 'package:flutter/material.dart';
import 'package:mobilni_zpevnik/utils/shared_ui_constants.dart';
import 'package:mobilni_zpevnik/widgets/menu_option.dart';
import 'package:mobilni_zpevnik/widgets/ui_gaps.dart';

class BottomSheetMenu extends StatelessWidget {
  final Widget menuHeader;
  final List<MenuOption> menuOptions;

  const BottomSheetMenu({
    super.key,
    required this.menuOptions,
    required this.menuHeader,
  });

  static void show(
      BuildContext context, Widget menuHeader, List<MenuOption> menuOptions) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(STANDARD_RADIUS),
          topRight: Radius.circular(STANDARD_RADIUS),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return BottomSheetMenu(
            menuHeader: menuHeader, menuOptions: menuOptions);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SmallGap(),
        _buildSwipeIndicator(context),
        menuHeader,
        const Divider(height: 1),
        for (var option in menuOptions)
          ListTile(
            leading: Icon(option.icon),
            title: Text(option.title),
            onTap: option.onTap,
          ),
      ],
    );
  }

  Widget _buildSwipeIndicator(BuildContext context) {
    return Container(
      width: 40.0,
      height: 4.0,
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(SMALL_RADIUS),
      ),
    );
  }
}
