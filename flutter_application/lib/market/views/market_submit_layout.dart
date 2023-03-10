import 'package:flutter/material.dart';
import 'package:flutter_application/market/controllers/market_controller.dart';
import 'package:get/get.dart';

class MarketSubmitLayout extends StatelessWidget {
  int selectedPage = 0;
  MarketController marketController = Get.put(MarketController());
  MarketSubmitLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => marketController.isLoading.value
        ? const Center(child: CircularProgressIndicator())
        : DefaultTabController(
            length: marketController.tabHeaders.length,
            initialIndex: selectedPage,
            child: Scaffold(
              appBar: AppBar(
                  title: Center(child: Text('Market')),
                  bottom: TabBar(
                    tabs: marketController.tabHeaders,
                    controller: marketController.tabController,
                    indicatorColor: Colors.white,
                  )),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: marketController.tabController,
                children: marketController.tabViews,
              ),
            ),
          ));
  }
}
