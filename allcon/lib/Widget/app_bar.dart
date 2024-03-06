import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final Widget? actions;
  final Function()? onActionPressed;
  final String? textFontFamily;
  final bool automaticallyImplyLeading;

  const MyAppBar({
    required this.text,
    this.actions,
    this.onActionPressed,
    this.textFontFamily,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        '$text',
        style: TextStyle(
          color: Colors.black87,
          fontFamily: textFontFamily,
          fontWeight: FontWeight.w800,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 3,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: <Widget>[
        if (actions != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              icon: actions!,
              color: Colors.deepPurple.withOpacity(0.85),
              onPressed: onActionPressed,
            ),
          )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
