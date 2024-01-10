import 'package:flutter/material.dart';
import '../pages/calendar.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'ALLCON',
        style: TextStyle(fontFamily: 'Cafe24Moyamoya'),
      ),
      centerTitle: true,
      backgroundColor: Colors.redAccent,
      elevation: 6.0,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.calendar_month),
          color: Colors.white,
          onPressed: () {
            /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Calendar())
            )*/
          },
        ),
        SizedBox(width: 5.0),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
