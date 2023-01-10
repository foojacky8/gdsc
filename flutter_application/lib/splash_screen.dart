import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final Color startingColor = const Color(0xff393a3e);
  final Color endingColor = const Color(0xff27282c);
  final double colorStopOne = 0.0;
  final double colorStopTwo = 0.8;

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [startingColor, endingColor],
          stops: [colorStopOne, colorStopTwo],
        ),
      ),
      child: Container(
        alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset('assets/raiden.jpg',)),
    ));
  }
}
