import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application/blockchain/controllers/blockchain_controller.dart';
import 'package:flutter_application/blockchain/widgets/blockchain_buy_detail.dart';
import 'package:get/get.dart';

import '../widgets/blockchain_table.dart';

class BlockChainPage extends StatelessWidget {
  BlockChainPage({super.key});

  BlockChainController controller = Get.put(BlockChainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('BlockChain')),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              // child: controller.buildDataTable(),
              child: Column(
                children: [
                  BlockChainTable(),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}