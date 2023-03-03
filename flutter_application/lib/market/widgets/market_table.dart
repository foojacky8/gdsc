import 'package:flutter/material.dart';
import 'package:flutter_application/market/controllers/market_controller.dart';
import 'package:get/get.dart';

class MarketTableData extends GetView<MarketController> {
  // MarketBuyController marketBuyController = Get.put(MarketBuyController());
  String action;
  MarketTableData({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          const Text('Current market'),
          Obx(() => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
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
                      rows: (action == 'Buy'
                              ? controller.buyData
                              : controller.sellData)
                          .map((e) => DataRow(cells: [
                                DataCell(Text(e.bidID.toString())),
                                DataCell(Text(e.buyOrSell.toString())),
                                DataCell(Text(e.biddingPrice.toString())),
                                DataCell(Text(e.energyAmount.toString())),
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