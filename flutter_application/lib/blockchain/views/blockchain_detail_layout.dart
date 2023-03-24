import 'package:flutter/material.dart';
import 'package:flutter_application/blockchain/controllers/blockchain_controller.dart';
import 'package:flutter_application/blockchain/widgets/blockchain_buy_detail.dart';
import 'package:flutter_application/blockchain/widgets/blockchain_sell_detail.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class BlockChainDetailLayout extends GetView<BlockChainController>{

  String hash;
  BlockChainDetailLayout({super.key, required this.hash});
  

  @override
  Widget build(BuildContext context) {
    controller.getCurrentMarket(hash);

    return Scaffold(
      appBar: AppBar(
        title:Text('Summary'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              // child: controller.buildDataTable(),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('BUY', 
                        style: TextStyle(fontSize: 20, 
                        fontWeight: FontWeight.bold), 

                      ),
                      BlockChainBuyDetail(),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Divider(
                  ),
                  SizedBox(height: 20,),

                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('SELL', style: TextStyle(fontSize: 20, 
                        fontWeight: FontWeight.bold
                      ),),
                      BlockChainBuyDetail(),
                    ],
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}