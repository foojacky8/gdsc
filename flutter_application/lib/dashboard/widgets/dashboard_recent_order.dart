import 'package:flutter/material.dart';
import 'package:flutter_application/market/controllers/market_controller.dart';
import 'package:get/get.dart';

import '../../profile/widgets/recent_order.dart';

class DashboardRecentOrder extends GetView<MarketController> {
  // MarketBuyController marketBuyController = Get.put(MarketBuyController());
  DashboardRecentOrder ({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.2,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Order',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(RecentOrder());
                },
                child: Text(
                  'See All',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
              )
            ],
          ),
          Obx(() => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
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
                      rows: (controller.recentData.take(2))
                          .map((e) => DataRow(
                            cells: [
                                DataCell(
                                  Container(
                                    width: 50,
                                    child: Text(
                                      e.bidID.toString(), 
                                      overflow: TextOverflow.ellipsis
                                      )
                                    )
                                  ),
                                DataCell(Text(e.buyOrSell.toString())),
                                DataCell(Text(e.biddingPrice.toString())),
                                DataCell(
                                  Container(
                                    width: 50,
                                    child: 
                                    Text(
                                      e.energyAmount.toString(),
                                      overflow: TextOverflow.ellipsis))),
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
        ],
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

// Container(
//                         padding: EdgeInsets.all(10),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text('Recent Order', 
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 ),
                              
//                                 GestureDetector(
//                                   onTap: () {
//                                     Get.to(RecentOrder());
//                                   },
//                                   child: Text('See All',
//                                       style: TextStyle(
//                                       color: Colors.blue,
//                                       ),
//                                     ),
//                                 )
                            
//                               ],
//                             ),
//                             SizedBox(height: 5,),
//                             Container(
//                               child: Table(
//                                 children: [
//                                   TableRow(
//                                     children: [
//                                       Text(''),
//                                       Text('Order ID'),
//                                       Text('Energy (kWh)'),
//                                       Text('Price (RM)'),
//                                       Text('Action'),
//                                     ]
//                                   ),
//                                   TableRow(
//                                     children: [
//                                       Text('BUY'),
//                                       Text('123'),
//                                       Text('10.0)'),
//                                       Text('10.0'),
//                                       Icon(Icons.delete, color: Colors.blue,)
//                                     ]
//                                   ),
//                                   TableRow(
//                                     children: [
//                                       Text('SELL'),
//                                       Text('124'),
//                                       Text('20.0'),
//                                       Text('10.0'),
//                                       Icon(Icons.delete, color: Colors.blue,)
//                                     ]
//                                   ),
//                                   TableRow(
//                                     children: [
//                                       Text('BUY'),
//                                       Text('125'),
//                                       Text('20.0'),
//                                       Text('20.0'),
//                                       Icon(Icons.delete, color: Colors.blue,)
//                                     ]
//                                   ),
//                                 ]
//                                 ),
//                             )
//                           ],
//                         ),
//                       ),