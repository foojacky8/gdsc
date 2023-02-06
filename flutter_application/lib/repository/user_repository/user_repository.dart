import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/authentication/models/user.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(MyUser user) async {
    await _db
        .collection('users')
        .add(user.toJson())
        .whenComplete(() => Get.snackbar(
            "Success", "Your account has been created",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green))
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again later",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red);
    });
  }

  getUserByEmail(String email) async {
    final snapshot =
        await _db.collection('users').where('email', isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => MyUser.fromSnapshot(e)).single;
    return userData;
  }

  getAllUsers() async {
    final snapshot = await _db.collection('users').get();
    final userData = snapshot.docs.map((e) => MyUser.fromSnapshot(e)).toList();
    return userData;
  }

  updateUser(MyUser user) async {
    await _db
        .collection('users')
        .doc(user.id)
        .update(user.toJson())
        .whenComplete(() => Get.snackbar(
            "Success", "Your account has been updated",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green))
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again later",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red);
    });
  }

  MyUser createUserFromSignupData(SignupData signupData) {
    return MyUser(
        username: signupData.name!,
        email: signupData.name!,
        id: signupData.name!);
  }
}
