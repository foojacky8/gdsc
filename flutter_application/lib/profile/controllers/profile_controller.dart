import 'package:flutter_application/authentication/models/user.dart';
import 'package:flutter_application/repository/authentication_repository/authetication_repository.dart';
import 'package:flutter_application/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final AutheticationRepository _authenticationRepository =
      Get.put(AutheticationRepository());
  final UserRepository _userRepository = Get.put(UserRepository());

  getUserData() {
    final email = _authenticationRepository.firebaseUser.value?.email;
    if (email != null) {
      return _userRepository.getUserByEmail(email);
    } else {
      Get.snackbar('Error', "Please login to continue");
    }
  }

  getAllUserData() async {
    return await _userRepository.getAllUsers();
  }

  updateUserData(User user) async {
    await _userRepository.updateUser(user);
  }

  
}
