import 'package:flutter/material.dart';
import 'package:flutter_application/market/models/energy_request.dart';
import 'package:flutter_application/repository/market_repository/market_repository.dart';
import 'package:get/get.dart';
import '../widgets/market_buy.dart';
import '../widgets/market_sell.dart';

class MarketController extends GetxController 
    with GetTickerProviderStateMixin {

  List<Widget> tabViews = [];
  List<Widget> tabHeaders = [];
  late final TabController tabController;
  RxInt selectedIndex = 0.obs;

  RxInt count = 0.obs;
  final data = List<EnergyRequest>.empty().obs;

  static MarketController to = Get.find();
  MarketRepository marketRepository = Get.put(MarketRepository());

  @override
  void onInit() {
    super.onInit();
    tabHeaders = [
      Tab(text: 'Buy'),
      Tab(text: 'Sell')
    ];
    tabViews = [
      MarketBuyView(),
      MarketSellView()
    ];
    tabController = TabController(
      initialIndex: selectedIndex.value,
      length: tabHeaders.length, 
      vsync: this);
  }

  @override
  void onClose() {
    super.onClose();
  }

  void updateTabController (int index) {
    selectedIndex.value = index;
    tabController.animateTo(index);
  }

  void addItem (EnergyRequest item) {
    data.add(item);
    count.value++;
    print('Count: $count');
  }
}