import 'package:flutter/material.dart';
import 'package:flutter_application/market/controllers/market_controller.dart';
import 'package:get/get.dart';

import '../controllers/blockchain_controller.dart';

class BlockChainBuyDetail extends GetView<BlockChainController> {
  // MarketBuyController marketBuyController = Get.put(MarketBuyController());
  BlockChainBuyDetail({super.key});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Obx(() => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    // height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width,
                    child: DataTable(
                        columnSpacing: 12,
                        horizontalMargin: 12,
                        columns: const [
                          DataColumn(
                            label: Text('UserID'),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text('Price', softWrap: true,),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text('ToGrid', softWrap: true,)),
                          ),
                          DataColumn(
                            label: Text('ToMarket'),
                          ),
                        ],
                        rows: (controller.buyCurrentDetail.value)
                            .map((e) => DataRow(cells: [
                                  DataCell(
                                    Container(
                                        width: 80,
                                        child: Text(
                                          e.userID.toString(), 
                                          overflow: TextOverflow.ellipsis)),
                                    ),
                                  DataCell(
                                      Text(
                                        double.parse((e.price).toStringAsFixed(2)).toString())
                                        ),
                                  DataCell(
                                    Text(
                                      double.parse((e.toGrid).toStringAsFixed(2)).toString())),
                                  DataCell(
                                    Text(
                                      double.parse((e.toMarket).toStringAsFixed(2)).toString())),
                                ]))
                            .toList()),
                  ))
          ],
        ),
      ),
    );

    
  }
}

// Widget getDataTableBuy(context, snapshot) {
//   return Center(
//     child: SizedBox(
//       height: MediaQuery.of(context).size.height * 0.35,
//       width: MediaQuery.of(context).size.width * 0.8,
//       child: DataTable(
//         columnSpacing: 12,
//         horizontalMargin: 12,
//         columns: const [
//           DataColumn(
//             label: Text('BidID'),
//           ),
//           DataColumn(
//             label: Text('Actions'),
//           ),
//           DataColumn(
//             label: Text('BiddingPrice'),
//           ),
//           DataColumn(
//             label: Text('Energy'),
//           ),
//         ],
//         rows: snapshot.data!.marketdepth
//             .map((e) => DataRow(cells: [
//                   DataCell(Text(e.bidID.toString())),
//                   DataCell(Text(e.buyOrSell.toString())),
//                   DataCell(Text(e.biddingPrice.toString())),
//                   DataCell(Text(e.energyAmount.toString())),
//                 ]))
//             .toList(),
//       ),
//     ),
//   );
// }