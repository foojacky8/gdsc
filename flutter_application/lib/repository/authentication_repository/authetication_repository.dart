import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application/repository/authentication_repository/exceptions/login_with_email_password_failure.dart';
import 'package:flutter_application/repository/authentication_repository/exceptions/signup_with_email_password_failure.dart';
import 'package:get/get.dart';

class AutheticationRepository extends GetxController {
  static AutheticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = _auth.currentUser.obs;
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  void _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll('/signupScreen');
    } else {
      Get.offAll('/splashScreen');
    }
  }

  Future<String?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      firebaseUser.value != null
          ? Get.offAll('/splashScreen')
          : Get.offAll('/signupScreen');
    } on FirebaseAuthException catch (e) {
      final exception = SignupWithEmailPasswordFailure.code(e.code);
      // Get.snackbar('Error creating account - ', exception.message);
      return exception.message;
    } catch (_) {
      final exception = SignupWithEmailPasswordFailure();
      // Get.snackbar('Error creating account - ', exception.message);
     return exception.message;
    }
    return null;
  }

  Future<String?> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      final exception = LoginWithEmailPasswordFailure.code(e.code);
      // Get.snackbar('Error signing in -', exception.message);
      return exception.message;
    } catch (_) {
      final exception = LoginWithEmailPasswordFailure();
      // Get.snackbar('Error signing in - ', exception.message);
      return exception.message;
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      Get.snackbar('Error signing out', e.toString());
    }
  }
}
