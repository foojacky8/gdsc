import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/market_buy.dart';
import '../widgets/market_sell.dart';

class MarketController extends GetxController 
    with GetTickerProviderStateMixin {

  List<Widget> tabViews = [];
  List<Widget> tabHeaders = [];
  late final TabController tabController;
  RxInt selectedIndex = 0.obs;

  static MarketController to = Get.find();

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

}