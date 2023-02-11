import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/market/controllers/market_controller.dart';
import 'package:flutter_application/market/views/market_submit_layout.dart';
import 'package:get/get.dart';

import '../../profile/widgets/recent_order.dart';
import '../widgets/market_buy.dart';
import '../widgets/market_sell.dart';

class MarketLatestPrice extends StatelessWidget {
  MarketLatestPrice({super.key});

  MarketController controller = Get.put(MarketController());

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
                    Get.to(MarketSubmitLayout(selectedPage: 0));
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
                    Get.to(MarketSubmitLayout(selectedPage: 1,));
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

            SizedBox(height: 50),

            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                child: DataTable(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  columnSpacing: 12,
                  horizontalMargin: 12,

                  columns: 
                  [
                    DataColumn(
                    label: Text('Bid'),
                    ),

                    DataColumn(
                    label: Text('MYR'),
                    ),

                    DataColumn(
                      label: Text('Ask'),
                    ),

                    DataColumn(
                      label: Text('MYR'))
                  ], 
                  rows:
                  [
                    DataRow(cells: [
                      DataCell(Text('10 kWh')),
                      DataCell(Text('10.0')),
                      DataCell(Text('10 kWh')),
                      DataCell(Text('20.0')),
                    ]
                    ),
                  ], 
                ),
              ),
            ),


            
          ],
        ),
      ),
    );
  }
}