import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/authentication/models/user.dart';
import 'package:flutter_application/repository/api/api_constants.dart';
import 'package:flutter_application/repository/api/api_error.dart';
import 'package:flutter_application/repository/api/api_response.dart';
import 'package:flutter_application/repository/api/energy_data_response.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(MyUser user) async {
    final energyData = await getUserEnergyData();
    user.genData = energyData!.genData;
    user.useData = energyData.useData;

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
    );
  }

  Future<EnergyDataResponse?> getUserEnergyData() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http
          .get(Uri.http(ApiConstants.baseUrl, ApiConstants.getEnergyDataUrl));

      switch (response.statusCode) {
        case 200:
          apiResponse.data = response.body;
          break;
        case 202:
          apiResponse.data = response.body;
          break;
        case 400:
          apiResponse.apiError = ApiError.fromJson(jsonDecode(response.body));
          break;
        case 401:
          apiResponse.apiError = ApiError.fromJson(jsonDecode(response.body));
          break;
        default:
          apiResponse.apiError = ApiError.fromJson(jsonDecode(response.body));
          break;
      }

      //process the API response data
      final energyDataResponse = jsonDecode(response.body);
      final energyData = EnergyDataResponse.fromJson(energyDataResponse);
      return energyData;
    } on SocketException catch (e) {
      apiResponse.apiError = ApiError(error: e.message);
    }
    return null;
  }
}
