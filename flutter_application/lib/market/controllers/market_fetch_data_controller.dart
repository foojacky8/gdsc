import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/market/controllers/market_controller.dart';
import 'package:flutter_application/market/models/energy_request.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


import '../../repository/api/api_constants.dart';
import '../models/market.dart';

class MarketFetchDataController extends GetxController{

  late Future<Market> futureMarket;
  final MarketController myController = Get.put(MarketController());
  Market market = Market(marketdepth: []);

  @override
  void onInit() {
    super.onInit();

    String userId = AuthenticationRepository.instance.firebaseUser.value!.uid;
    FirebaseFirestore.instance
      .collection('users')
      .doc('user1').set(
    );


    futureMarket = fetchData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<Market> fetchData() async {
    final response = await http.get(Uri.http(ApiConstants.baseUrl, 'createRequest'));
    if (response.statusCode == 200) {
      final market = Market.fromJson(json.decode(response.body));

      if (market != null) {
        for (var item in market.marketdepth) {
          myController.addItem(item);
        }
      }
      return market;

    } else {
      throw Exception('Failed to load data');
    }
  }

  Future postData (EnergyRequest energyRequest) async {
    final response = await http.post(Uri.http(ApiConstants.baseUrl, 'energyRequest'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer TPyh6lJ9MAWDq9no5jvF9ukeQGq1}',
        },
        body: jsonEncode(<String, dynamic>{
          'energyAmount': energyRequest.energyAmount,
          'biddingPrice': energyRequest.biddingPrice,
          'BuyOrSell': energyRequest.buyOrSell,
        }));
    if (response.statusCode == 201) {
      print('Successfully created');
      handleInit();
      // return response;
      return EnergyRequest.fromJson(jsonDecode(response.body));

    } else {
      throw Exception('Failed to load data');
    }
  }

  Future handleInit () async {
    final response = await http.get(Uri.http(ApiConstants.baseUrl, 'initAuction'));
    if (response.statusCode == 200) {
      print('Successfully initialized');
    } else {
      throw Exception('Failed to load data');
    }
  }


  Future handleEnergyForecast() async {
    final response = await http.get(Uri.http(ApiConstants.baseUrl, 'handleEnergyForecast'));
    if (response.statusCode == 200) {
      print('Successfully initialized');
      readCsv();
      return response;
    } else {
      throw Exception('Failed to load data');
    }
  }

  void readCsv() async {
    final file = await File('assets/energy_forecast.csv').readAsString();
    print(file);
  }

  


}