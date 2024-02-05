import 'package:flutter/material.dart';

class SeatMain extends StatefulWidget {
  const SeatMain({super.key});

  @override
  State<SeatMain> createState() => _SeatMainState();
}

class _SeatMainState extends State<SeatMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("000 공연장"),
      ),
    );
  }
}
