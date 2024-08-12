import 'package:flutter/material.dart';
import 'package:presentation/features/main/main_screen.dart';

class MenuItemWidget extends StatelessWidget {
  final MenuItem menuItem;
  final Function(MenuItem menuItem) onMenuTap;
  final Color backgroundColor;

  const MenuItemWidget({
    super.key,
    required this.menuItem,
    required this.onMenuTap,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onMenuTap(menuItem),
      behavior: HitTestBehavior.translucent,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            menuItem.displayName,
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }
}
