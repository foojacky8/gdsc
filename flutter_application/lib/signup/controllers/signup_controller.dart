import 'package:flutter/cupertino.dart';
import 'package:flutter_application/authetication/authetication_repository.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  final users = const {
    'niama@gmail.com': '12345',
    'hunter@gmail.com': 'hunter',
  };

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return AutheticationRepository.instance
          .createUserWithEmailAndPassword(data.name!, data.password!);
    });
  }

  Future<String?> authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return AutheticationRepository.instance
          .signInWithEmailAndPassword(data.name, data.password);
    });
  }

  Future<String?> recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }
}
