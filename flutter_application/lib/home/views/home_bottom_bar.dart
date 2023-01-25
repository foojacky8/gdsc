

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../controllers/home_bottom_appbar_controller.dart';

class HomeBottomAppBar extends GetView<HomeBottomAppBarController> {
  const HomeBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      height: MediaQuery.of(context).size.height * 0.08,
      items: controller.tabBottomList,
        onTap: (int i) {
          print('click index=$i');
          controller.bottomBarSelectedIndex.value = i;
        },
    );
  }
}