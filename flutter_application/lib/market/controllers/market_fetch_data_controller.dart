import 'dart:convert';
import 'package:flutter_application/market/controllers/market_controller.dart';
import 'package:flutter_application/market/models/order.dart';
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

  Future postData (Order order) async {
    final response = await http.post(Uri.http(ApiConstants.baseUrl, 'handleEnergyRequest'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'energyAmount': order.energyAmount,
          'biddingPrice': order.biddingPrice,
          'BuyOrSell': order.BuyOrSell,
        }));
    if (response.statusCode == 200) {
      print('success');
    } else {
      throw Exception('Failed to load data');
    }
  }


}