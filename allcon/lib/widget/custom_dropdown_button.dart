import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  final List<String> items;
  final String value;
  final ValueChanged<String?> onChanged;

  const CustomDropdownButton({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 95.0,
      child: DropdownButton(
        menuMaxHeight: 250.0,
        iconEnabledColor: Colors.deepPurple,
        items: widget.items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        value: widget.value,
        onChanged: widget.onChanged,
        elevation: 2,
      ),
    );
  }
}
