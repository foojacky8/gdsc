import 'package:flutter/material.dart';
import 'package:flutter_application/authentication/controllers/signup_controller.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../home/views/home_page.dart';

class MySignupScreen extends StatelessWidget {
  const MySignupScreen({super.key});
  Duration get loginTime => Duration(milliseconds: 2250);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return FlutterLogin(
      logo: AssetImage('assets/images/people2ppl.png'),
      title: 'Re:Energize',
      onLogin: controller.authUser,
      onSignup: controller.signupUser,

        loginProviders: [
          LoginProvider(
            icon: FontAwesomeIcons.google,
            label: 'Google',
            callback: () async {
              debugPrint('start google sign in');
              await Future.delayed(loginTime);
              debugPrint('stop google sign in');              
              return null;
            },
          )
        ],
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
      },
      onRecoverPassword: controller.recoverPassword,
    );
  }
}
