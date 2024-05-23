import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final Function()? onLeadingPressed;
  final Widget? actions;
  final Function()? onActionPressed;
  final String? textFontFamily;
  final bool automaticallyImplyLeading;
  final PreferredSizeWidget? bottom;

  const MyAppBar({
    super.key,
    required this.text,
    this.onLeadingPressed,
    this.actions,
    this.onActionPressed,
    this.textFontFamily,
    this.automaticallyImplyLeading = true,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        text,
        style: TextStyle(
          color: Colors.black87,
          fontFamily: textFontFamily,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: onLeadingPressed != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onLeadingPressed,
            )
          : null,
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: <Widget>[
        if (actions != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: IconButton(
              iconSize: 26.0,
              icon: actions!,
              color: Colors.deepPurple.withOpacity(0.85),
              onPressed: onActionPressed,
            ),
          )
      ],
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize {
    if (bottom != null) {
      // bottom 위젯이 있는 경우 AppBar의 높이에 bottom의 preferredSize 높이를 추가
      return Size.fromHeight(kToolbarHeight + bottom!.preferredSize.height);
    } else {
      return const Size.fromHeight(kToolbarHeight);
    }
  }
}
