import 'package:flutter/material.dart';
import 'package:flutter_application/signup/controllers/signup_controller.dart';
import 'package:flutter_application/splash_screen.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';

class MySignupScreen extends StatelessWidget {
  const MySignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return FlutterLogin(
      title: 'Re:Energize',
      onLogin: controller.authUser,
      onSignup: controller.signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        ));
      },
      onRecoverPassword: controller.recoverPassword,
    );
  }
}
