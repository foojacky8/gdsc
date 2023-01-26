import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../blockchain/views/blockchain_view.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../evcharge/views/evcharge_view.dart';
import '../../market/views/market_views.dart';
import '../../profile/views/profile_page.dart';

class HomeBottomAppBarController extends GetxController{
  RxList<TabItem> tabBottomList = RxList<TabItem>();
  RxInt bottomBarSelectedIndex = 0.obs;
  RxList<Widget> bottomBarPages = RxList<Widget>();

  void onInit(){
    super.onInit();
    tabBottomList.addAll([
      TabItem(icon: Icons.home, title: 'Home'), 
      TabItem(icon: MdiIcons.earth, title: 'Market'), 
      TabItem(icon: MdiIcons.swapHorizontal, title: 'Blockchain'),
      TabItem(icon: MdiIcons.lightningBolt, title: 'EV Charge'),
      TabItem(icon: Icons.person, title: 'Profile'),        
    ]);

    bottomBarPages.addAll(
      [
        DashboardPage(),
        MarketPage(),
        BlockChainPage(),
        EvChargePage(),
        ProfilePage(),
      ]
    );

    void onClose(){
      super.onClose();
    }
  }
}