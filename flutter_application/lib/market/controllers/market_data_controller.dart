import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/market/controllers/market_controller.dart';
import 'package:flutter_application/market/models/energy_request.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../repository/api/api_constants.dart';
import '../../repository/authentication_repository/authentication_repository.dart';
import '../models/forecast_energy.dart';
import '../models/market.dart';

class MarketDataController extends GetxController with GetTickerProviderStateMixin{

  late Future<Market> futureMarket;
  late Future<ForecastEnergy> futureEnergy;

  Market market = Market(marketdepth: []);
  final RxDouble _forecastGenData = 0.0.obs;
  final RxDouble _forecastUseData = 0.0.obs;
  RxDouble get forecastGenData => _forecastGenData;
  RxDouble get forecastUseData => _forecastUseData;
  static MarketDataController to = Get.find();

  @override
  void onInit() {
    super.onInit();

    // String userId = AuthenticationRepository.instance.firebaseUser.value!.uid;
    // final forecastGenData = 

    // final userRef = FirebaseFirestore.instance
    //   .collection('users')
    //   .doc('userId');

    // userRef.update({"forecastGenData": 123});


    // futureMarket = fetchData();
    futureEnergy = handleEnergyForecast();
    // futureEnergy.then((value) => _forecastGenData.value = value.genData);
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Future<Market> fetchData() async {
  //   final response = await http.get(Uri.http(ApiConstants.baseUrl, 'createRequest'));
  //   if (response.statusCode == 200) {
  //     final market = Market.fromJson(json.decode(response.body));

  //     if (market != null) {
  //       for (var item in market.marketdepth) {
  //         myController.addItem(item);
  //       }
  //     }
  //     return market;

  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }

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


  Future<ForecastEnergy> handleEnergyForecast() async {
    // var jsonBody = jsonEncode(energyRequest.toJson());
    // final response = await http.post(Uri.http(ApiConstants.baseUrl, 
    //ApiConstants.handleEnergyRequestUrl), body: jsonBody, headers: headers);
    String userId = AuthenticationRepository.instance.firebaseUser.value!.uid;
    String uri = Uri.http(ApiConstants.baseUrl, 'energyForecast').toString();
    final response = await http.get(Uri.parse('$uri?id=$userId'),
        headers: <String, String>{
          'Authorization': 'Bearer $userId}'
        }
    );
    if (response.statusCode == 202){
      // await Future.delayed(Duration(seconds: 1));
      print('Successfully initialized');
      final model = ForecastEnergy.fromJson(jsonDecode(response.body));
      _forecastGenData.value = model.genData;
      _forecastUseData.value = model.useData;
      update();
      return model;
    }
    else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  void readCSV() async {
    final file = await File('assets/energy_forecast.csv').readAsString();
    print(file);
  }

}