import 'package:allcon/Util/Theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: lightGray,
        child: Center(
            child: SpinKitWave(
          color: Colors.deepPurple,
          size: 50.0,
          duration: Duration(seconds: 1),
        )),
      ),
    );
  }
}
