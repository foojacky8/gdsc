import 'package:flutter/material.dart';

import 'home_bottom_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      bottomNavigationBar: HomeBottomAppBar(),
    );
  }
}