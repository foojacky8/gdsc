import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/market/controllers/market_controller.dart';
import 'package:flutter_application/market/controllers/market_data_controller.dart';
import 'package:flutter_application/market/models/market.dart';
import 'package:flutter_application/market/views/market_submit_layout.dart';
import 'package:get/get.dart';

import '../../profile/widgets/recent_order.dart';
import '../widgets/market_buy.dart';
import '../widgets/market_sell.dart';
import '../widgets/market_stat.dart';

class MarketLatestPrice extends StatelessWidget {
  MarketLatestPrice({super.key});

  MarketController controller = Get.put(MarketController());
  MarketDataController fetchDataController = Get.put(MarketDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Market')),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(RecentOrder());
                  },
                  child: Text('History',
                      style: TextStyle(
                      color: Colors.green,
                      ),
                    ),
                )
              ],),
            Text('Energy per kWh/MYR',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('RM 10.00',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.green)),
                Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text('+ 0.10%',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                )
              ],
            ),
            
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              Text('Last Updated: 12:00 PM',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ],),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(MarketSubmitLayout());
                    MarketController.to.updateTabController(0);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text('Buy',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Get.to(MarketSubmitLayout());
                    MarketController.to.updateTabController(1);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text('Sell',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                )

              ],
            ),

            SizedBox(height: 20),

            MarketStat(),

            SizedBox(height: 30),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Market Depth'),
                FutureBuilder(
                  future: fetchDataController.futureMarket,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                      }
                    else {
                      return Center(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: DataTable(
                            columnSpacing: 12,
                            horizontalMargin: 12,
                      
                            columns: 
                            [
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
                            rows:
                            // [
                            //   DataRow(cells: [
                            //     DataCell(Text('10 kWh')),
                            //     DataCell(Text('10.0')),
                            //     DataCell(Text('2')),
                            //     DataCell(Text('10 kWh')),
                            //     DataCell(Text('20.0')),
                            //     DataCell(Text('2')),
                            //   ]
                            //   ),
                            // ], 
                            snapshot.data!.marketdepth.map((e) => DataRow(cells: [
                              DataCell(Text(e.bidID.toString())),
                              DataCell(Text(e.BuyOrSell.toString())),
                              DataCell(Text(e.biddingPrice.toString())),
                              DataCell(Text(e.energyAmount.toString())),
                            ])).toList(),
                          ),
                        ),
                        ]
                      ),
                    );
                  }
                }
              ),
            //   FutureBuilder(
            //   future: fetchDataController.futureMarket,
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       return 
            //         Container(
            //           height: 200,
            //           child: ListView.builder(
            //             itemCount: snapshot.data!.marketdepth.length,
            //             itemBuilder: (context, index) {
            //               return Row(
            //                 children: [
            //                   Text('${snapshot.data!.marketdepth[index].bidID}'),
            //                   Text('${snapshot.data!.marketdepth[index].BuyOrSell}'),
            //                   Text('${snapshot.data!.marketdepth[index].energyAmount}'),
            //                   Text('${snapshot.data!.marketdepth[index].biddingPrice}'),
            //                 ],
            //               );
            //             }
            //           ),
            //         );
            //       // Column(
            //       //   crossAxisAlignment: CrossAxisAlignment.start,
            //       //   children: [
            //       //     Text('Testing'),
            //       //     Text('BIDID ${snapshot.data!.marketdepth[0]}'),
            //       //     Text('USERID ${snapshot.data!.userID}'),
            //       //     Text('BIDTYPE ${snapshot.data!.energyAmount}'),
            //       //     Text('BIDPRICE ${snapshot.data!.BuyOrSell}'),
            //       //     Text('BIDAMOUNT ${snapshot.data!.biddingPrice}'),
            //       //   ],
            //       // );
            //     } else if (snapshot.hasError) {
            //       return Text('${snapshot.error}');
            //     }
            //     return CircularProgressIndicator();
            //   },
            // ),
            ],
          ),            
          ],
        ),
      ),
    );
  }
}