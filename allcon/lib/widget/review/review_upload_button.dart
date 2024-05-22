import 'package:allcon/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewUploadButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;

  const ReviewUploadButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  @override
  State<ReviewUploadButton> createState() => _ReviewUploadButtonState();
}

class _ReviewUploadButtonState extends State<ReviewUploadButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        backgroundColor: lightlavenderColor,
        elevation: 0.5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(widget.icon, size: 25.0),
          const SizedBox(width: 8),
          Text(
            widget.label,
            style: const TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
