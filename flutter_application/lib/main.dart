import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application/authetication/authetication_repository.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/get_routes.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AutheticationRepository()));
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/signupScreen',
      getPages: AppRoutes.routes,
    );
  }
}
