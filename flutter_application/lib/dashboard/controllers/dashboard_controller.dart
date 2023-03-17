import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/market/controllers/market_controller.dart';
import 'package:get/get.dart';

import '../../market/models/energy_request.dart';

class DashboardController extends GetxController {

  RxList<EnergyRequest> data = List<EnergyRequest>.empty().obs;

  void onInit() {
    super.onInit();
    MarketController controller = Get.put(MarketController());
    controller.marketRepository.getAllEnergyRequestFromFirestore();
  }

  @override
  void onClose() {
    super.onClose();
  }

}