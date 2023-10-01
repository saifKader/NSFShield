import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPress;
  final Color? backgroundColor;
  final bool useRoundedShape;

  CustomAppBar({
    required this.title,
    this.onBackPress,
    this.backgroundColor,
    this.useRoundedShape = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      shape: useRoundedShape
          ? const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      )
          : null,
      backgroundColor: backgroundColor ?? theme.colorScheme.primary,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: onBackPress ?? () {
          Navigator.of(context).pop(); // Default behavior is to pop the screen.
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
