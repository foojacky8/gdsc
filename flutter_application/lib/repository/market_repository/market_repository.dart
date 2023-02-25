import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/market/models/energy_request.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class MarketRepository extends GetxController {
  static MarketRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createEnergyRequest(EnergyRequest energyRequest) async {
    await _db
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
  }

  getEnergyRequest() async {
    return await _db.collection('energyRequest').get();
  }
}
