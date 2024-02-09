import 'package:flutter/material.dart';
import '../pages/calendar.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'ALLCON',
        style: TextStyle(fontFamily: 'Cafe24Moyamoya'),
      ),
      centerTitle: true,
      backgroundColor: Colors.redAccent,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.calendar_month),
          color: Colors.white,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Calendar()));
          },
        ),
        const SizedBox(width: 5.0),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
