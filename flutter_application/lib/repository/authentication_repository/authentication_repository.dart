import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application/repository/authentication_repository/exceptions/login_with_email_password_failure.dart';
import 'package:flutter_application/repository/authentication_repository/exceptions/signup_with_email_password_failure.dart';
import 'package:flutter_application/repository/user_repository/user_repository.dart';
import 'package:flutter_application/storage/secure_storage.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  UserRepository userRepository = Get.put(UserRepository());

  // ! FirebaseAuth only works with Flutter only approach atm
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
      Get.offAllNamed('/signupScreen');
    } else {
      Get.offAllNamed('/');
    }
  }

  Future<String?> createUserWithEmailAndPassword(
      String email, String password, SignupData signupData) async {
    // Flutter only approach
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // create user entry in Firestore
      userRepository
          .createUser(userRepository.createUserFromSignupData(signupData), firebaseUser.value!.uid);

      // save the firebase user jwt token in local storage
      SecureStorage.setJwt(await firebaseUser.value!.getIdToken(true));

      firebaseUser.value != null
          ? Get.offAllNamed('/')
          : Get.offAllNamed('/signupScreen');
    } on FirebaseAuthException catch (e) {
      final exception = SignupWithEmailPasswordFailure.code(e.code);
      return exception.message;
    } catch (e) {
      final exception = SignupWithEmailPasswordFailure();
      return exception.message;
    }

    return null;
  }

  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
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

  // void _changePassword(String currentPassword, String newPassword) async {
  //   final user = await FirebaseAuth.instance.currentUser;
  //   String? email = AuthenticationRepository.instance.firebaseUser.value!.email;
    
  //   final cred = EmailAuthProvider.credential(
  //       email: email, password: currentPassword);

  //   user?.reauthenticateWithCredential(cred).then((value) {
  //     user.updatePassword(newPassword).then((_) {
  //       //Success, do something
  //     }).catchError((error) {
  //       //Error, show something
  //     });
  //   }).catchError((err) {
  //     //Error, show something
  //   });
  // }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      Get.snackbar('Error signing out', e.toString());
    }
  }
}
