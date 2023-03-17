import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../market/controllers/market_controller.dart';

class RecentOrder extends GetView<MarketController> {
  const RecentOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Recent Order')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
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
                        DataColumn(
                          label: Text(''),
                        ),
                      ],
                      rows: (controller.recentData)
                          .map((e) => DataRow(
                            cells: [
                                DataCell(Text(e.bidID.toString())),
                                DataCell(Text(e.buyOrSell.toString())),
                                DataCell(Text(e.biddingPrice.toString())),
                                DataCell(Text(e.energyAmount.toString())),
                                DataCell(IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Confirm Delete'),
                                        content: Text('Are you sure you want to delete this order?'),
                                        actions: [
                                          TextButton(
                                            child: Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text('Delete'),
                                            onPressed: () {
                                              // call the deleteDocument function with the documentId
                                              controller.deleteDocument(e.bidID.toString());
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    }
                                    );
                                  },
                                ))
                              ]))
                          .toList()),
                )
              )
      ),
    );
  }
}