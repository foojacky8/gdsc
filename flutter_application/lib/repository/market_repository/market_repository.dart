import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/market/models/energy_request.dart';
import 'package:flutter_application/repository/api/api_constants.dart';
import 'package:flutter_application/repository/api/api_error.dart';
import 'package:flutter_application/repository/api/api_response.dart';
import 'package:flutter_application/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter_application/storage/secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class MarketRepository extends GetxController {
  static MarketRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  addEnergyRequestToFirestore(EnergyRequest energyRequest,
      {bool updateObjectWithDocumentId = false}) async {
    DocumentReference docRef = await _db
        .collection('energyRequest')
        .add(energyRequest.toJson())
        .whenComplete(() => Fluttertoast.showToast(
            msg: "Bid Submmited",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            // backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 14.0));

    if (updateObjectWithDocumentId) {
      energyRequest.bidID = docRef.id;
      await docRef.update(energyRequest.toJson());
    }
  }

  getAllEnergyRequestFromFirestore() async {
    return await _db.collection('energyRequest').get();
  }

  addEnergyRequestToGoBackend(EnergyRequest energyRequest) async {
    // convert the energyRequest object to JSON string
    var jsonBody = jsonEncode(energyRequest.toJson());
    var jwt = await AuthenticationRepository.instance.firebaseUser.value!
        .getIdToken();
    var headers = {'Token': jwt};
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.post(
          Uri.http(ApiConstants.baseUrl, ApiConstants.handleEnergyRequestUrl),
          body: jsonBody,
          headers: headers);

      switch (response.statusCode) {
        case 200:
          apiResponse.data = response.body;
          break;
        case 201:
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
    } on SocketException catch (e) {
      apiResponse.apiError = ApiError(error: e.message);
    }
  }

  initAuction() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http
          .get(Uri.http(ApiConstants.baseUrl, ApiConstants.handleInitAuction));

      switch (response.statusCode) {
        case 200:
          apiResponse.data = response.body;
          break;
        case 201:
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
    } on SocketException catch (e) {
      apiResponse.apiError = ApiError(error: e.message);
    }

    Fluttertoast.showToast(
        msg: apiResponse.data.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 14.0);
  }
}
