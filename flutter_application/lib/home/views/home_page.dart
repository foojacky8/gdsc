import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'home_bottom_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Container(
        child: Image.asset('assets/images/raiden.jpg'),
        ),
      ),
      bottomNavigationBar: HomeBottomAppBar(),
    );
  }
}