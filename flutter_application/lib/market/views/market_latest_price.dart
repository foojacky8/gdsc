import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/market/views/market_views.dart';
import 'package:get/get.dart';

class MarketLatestPrice extends StatelessWidget {
  const MarketLatestPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Market')),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Center(
              child: Text('Latest Price',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ),
            
            SizedBox(height: 20),

            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.electric_bolt,
                    size: 50,
                    color: Colors.green,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Energy per kWh/MYR'),
                      Text('RM 10.00',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ]),
            ),

            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: DataTable2(
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
            Spacer(),
            CupertinoButton(
              color: Colors.green,
              borderRadius: BorderRadius.circular(25),
              child: Text('Trade Now'), 
              onPressed: () {
                Get.to(MarketPage());
              }
            )
            
          ],
        ),
      ),
    );
  }
}