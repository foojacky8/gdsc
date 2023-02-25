import 'package:flutter/material.dart';
import 'package:flutter_application/market/controllers/market_controller.dart';
import 'package:get/get.dart';

class MarketSubmitLayout extends StatelessWidget {

  int selectedPage = 0;
  MarketController marketController = Get.put(MarketController());
  MarketSubmitLayout({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<MarketController>(
      init: MarketController(),
      builder: (controller) {
        controller.selectedIndex.value = selectedPage;

        return Scaffold(
            appBar: AppBar(
              title: Center(child: Text('Market')),
              bottom: TabBar(
                tabs: controller.tabHeaders,
                controller: controller.tabController,
                indicatorColor: Colors.white,
              )
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller.tabController,
              children: controller.tabViews,
            ),
        );
      }
    );
  }
}