import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:flutter_application/market/controllers/market_fetch_data_controller.dart';

class MarketTableData extends StatelessWidget {
  MarketTableData({super.key});

  MarketFetchDataController fetchDataController = Get.put(MarketFetchDataController());


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: 
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
            ],
          ), 
    );
  }
}