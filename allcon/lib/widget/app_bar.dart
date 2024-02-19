import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/calendar.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final Widget? actions;
  final Function()? onActionPressed;
  final String? textFontFamily;

  const MyAppBar({
    required this.text,
    this.actions,
    this.onActionPressed,
    this.textFontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        '$text',
        style: TextStyle(
          color: Colors.black87,
          fontFamily: textFontFamily,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 5,
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
