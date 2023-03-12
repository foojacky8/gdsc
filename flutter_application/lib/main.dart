import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application/repository/authentication_repository/authentication_repository.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/get_routes.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, child!),
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(450, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
      ),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/signupScreen',
      
      getPages: AppRoutes.routes,
    );
  }
}
