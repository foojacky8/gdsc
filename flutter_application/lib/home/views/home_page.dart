import 'package:flutter/material.dart';
import 'package:flutter_application/home/controllers/home_bottom_appbar_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'home_bottom_bar.dart';

class HomePage extends StatelessWidget {
  
  HomeBottomAppBarController controller = Get.put(HomeBottomAppBarController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeBottomAppBarController>(
      builder: (controller) {
        return Scaffold(
          body: IndexedStack(
            index: controller.bottomBarSelectedIndex.value,
            children: controller.bottomBarPages,
          ),
          bottomNavigationBar: HomeBottomAppBar(),
        );
      }
    );
  }
}