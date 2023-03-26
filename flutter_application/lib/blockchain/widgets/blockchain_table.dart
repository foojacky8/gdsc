import 'package:flutter/material.dart';
import 'package:flutter_application/blockchain/views/blockchain_detail_layout.dart';
import 'package:flutter_application/market/controllers/market_controller.dart';
import 'package:get/get.dart';

import '../controllers/blockchain_controller.dart';

class BlockChainTable extends GetView<BlockChainController> {
  // MarketBuyController marketBuyController = Get.put(MarketBuyController());
  BlockChainTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      dataRowHeight: 50,
                      columns: const [
                        DataColumn(
                          label: Text('Date'),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text('No. of Transactions', softWrap: true,),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text('Total Energy Traded', softWrap: true,)),
                        ),
                        DataColumn(
                          label: Text('Detail'),
                        ),
                      ],
                      rows: (controller.blockChainData.value)
                          .map((e) => DataRow(cells: [
                                DataCell(
                                  Container(
                                      width: 80,
                                      child: Text(
                                        e.timestamp.toString(), 
                                        overflow: TextOverflow.clip)),
                                  ),
                                DataCell(
                                  Text(e.noOfTransaction.toString())),
                                DataCell(
                                  Text(
                                    double.parse((e.tradedEnergy).toStringAsFixed(2)).toString())),
                                    // e.tradedEnergy.toString())),
                                DataCell(
                                  IconButton(
                                  icon: Icon(Icons.info_outline_rounded, color: Colors.grey),
                                  onPressed: () {
                                    String hash = e.hash;
                                    Get.to(() => BlockChainDetailLayout(hash: hash));
                                  },
                                )),
                              ]))
                          .toList()),
                ))
        ],
      ),
    );

    
  }
}

Widget getDataTableBuy(context, snapshot) {
  return Center(
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width * 0.8,
      child: DataTable(
        columnSpacing: 12,
        horizontalMargin: 12,
        columns: const [
          DataColumn(
            label: Text('BidID'),
          ),
          DataColumn(
            label: Text('Actions'),
          ),
          DataColumn(
            label: Text('BiddingPrice'),
          ),
          DataColumn(
            label: Text('Energy'),
          ),
        ],
        rows: snapshot.data!.marketdepth
            .map((e) => DataRow(cells: [
                  DataCell(Text(e.bidID.toString())),
                  DataCell(Text(e.buyOrSell.toString())),
                  DataCell(Text(e.biddingPrice.toString())),
                  DataCell(Text(e.energyAmount.toString())),
                ]))
            .toList(),
      ),
    ),
  );
}