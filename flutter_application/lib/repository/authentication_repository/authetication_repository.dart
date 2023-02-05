import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application/authentication/models/user.dart';
import 'package:flutter_application/repository/authentication_repository/api/api_constants.dart';
import 'package:flutter_application/repository/authentication_repository/api/api_error.dart';
import 'package:flutter_application/repository/authentication_repository/api/api_response.dart';
import 'package:flutter_application/repository/authentication_repository/exceptions/login_with_email_password_failure.dart';
import 'package:flutter_application/repository/authentication_repository/exceptions/signup_with_email_password_failure.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
    // Flutter only approach
    // try {
    //   await _auth.createUserWithEmailAndPassword(
    //     email: email,
    //     password: password,
    //   );
    //   firebaseUser.value != null
    //       ? Get.offAll('/splashScreen')
    //       : Get.offAll('/signupScreen');
    // } on FirebaseAuthException catch (e) {
    //   final exception = SignupWithEmailPasswordFailure.code(e.code);
    //   // Get.snackbar('Error creating account - ', exception.message);
    //   return exception.message;
    // } catch (_) {
    //   final exception = SignupWithEmailPasswordFailure();
    //   // Get.snackbar('Error creating account - ', exception.message);
    //  return exception.message;
    // }

    // Flutter + Golang approach
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.post(Uri.parse(ApiConstants.loginUrl), body: {
      'email': email,
      'password': password,
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = MyUser.fromJson(jsonDecode(response.body));
        break;
      case 401:
        apiResponse.apiError = ApiError.fromJson(jsonDecode(response.body));
        break;
      default:
        apiResponse.apiError = ApiError.fromJson(jsonDecode(response.body));
        break;
    }
    } on SocketException {
      apiResponse.apiError = ApiError(error: 'Server error. Please try again');
    }

    // if api response contains data, most likely no error occured
    if (apiResponse.data != null) {
      firebaseUser.value != null
          ? Get.offAll('/splashScreen')
          : Get.offAll('/signupScreen');
    } 

    // if api response contains error, most likely error occured
    if (apiResponse.data == null && apiResponse.apiError != null) {
      final exception = SignupWithEmailPasswordFailure.code(apiResponse.apiError!.error);
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

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      Get.snackbar('Error signing out', e.toString());
    }
  }
}
