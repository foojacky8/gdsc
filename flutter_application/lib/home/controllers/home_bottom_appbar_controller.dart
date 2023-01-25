import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeBottomAppBarController extends GetxController{
  final int currentIndex = 0;
  RxList<TabItem> tabBottomList = RxList<TabItem>();
  RxInt bottomBarSelectedIndex = 0.obs;

  void onInit(){
    super.onInit();
    tabBottomList.addAll([
      TabItem(icon: Icons.home, title: 'Home'), 
      TabItem(icon: MdiIcons.earth, title: 'Market'), 
      TabItem(icon: MdiIcons.swapHorizontal, title: 'Blockchain'),
      TabItem(icon: MdiIcons.lightningBolt, title: 'EV Charge'),
      TabItem(icon: Icons.person, title: 'Profile'),        
    ]);

    void onClose(){
      super.onClose();
    }
  }
}