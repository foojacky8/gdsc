import 'package:flutter/cupertino.dart';
import 'package:flutter_application/authentication/models/user.dart';
import 'package:flutter_application/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter_application/repository/user_repository/user_repository.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  final UserRepository userRepository = Get.put(UserRepository());

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> signupUser(SignupData data) async {
    // await userRepository.createUser(createUserObject(data));
    return AuthenticationRepository.instance
        .createUserWithEmailAndPassword(data.name!, data.password!, data);
  }

  Future<String?> authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return AuthenticationRepository.instance
          .signInWithEmailAndPassword(data.name, data.password);
    });
  }

  Future<String?> recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      // if (!users.containsKey(name)) {
      //   return 'User not exists';
      // }
      return null;
    });
  }

  MyUser createUserObject(SignupData signupData) {
    return MyUser(
        username: signupData.name!,
        email: signupData.name!,
        id: signupData.name!);
  }
}
