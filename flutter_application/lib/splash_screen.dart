import 'package:flutter/material.dart';
import 'package:flutter_application/repository/authentication_repository/authetication_repository.dart';
import 'package:flutter_application/authetication/controllers/signup_controller.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SignupController> {
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
          child: Column(
            children: [
              Flexible(
                  flex: 4,
                  child: Image.asset(
                    'assets/images/raiden.jpg',
                  )),
              Flexible(
                  child: Ink(
                decoration: const ShapeDecoration(
                  color: Colors.lightBlue,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  onPressed: () => AutheticationRepository.instance.signOut(),
                  icon: const Icon(Icons.logout),
                  color: Colors.white,
                ),
              ))
            ],
          )),
    ));
  }
}
