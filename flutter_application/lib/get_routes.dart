import 'package:flutter_application/authentication/views/signup/my_signup_screen.dart';
import 'package:flutter_application/splash_screen.dart';
import 'package:get/get.dart';

import 'home/views/home_page.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/splashScreen', page: () => const SplashScreen(),),
    GetPage(name: '/', page: () => HomePage()),
    GetPage(name: '/signupScreen', page: (() => const MySignupScreen())),
  ];
}
