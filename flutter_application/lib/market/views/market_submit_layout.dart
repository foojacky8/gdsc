import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application/market/controllers/market_controller.dart';
import 'package:flutter_application/market/widgets/market_buy.dart';
import 'package:flutter_application/market/widgets/market_sell.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MarketSubmitLayout extends StatelessWidget {

  int selectedPage;
  MarketSubmitLayout({super.key, required this.selectedPage});

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