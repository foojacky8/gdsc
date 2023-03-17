import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application/market/controllers/market_data_controller.dart';
import 'package:flutter_application/profile/widgets/recent_order.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../controllers/dashboard_controller.dart';
import '../widgets/dashboard_forecast.dart';
import '../widgets/dashboard_recent_order.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isRecentOrder = true;

  DashboardController dashboardController = Get.put(DashboardController());
  MarketDataController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF198f4c),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Column(
                  children: [
                    //greeting row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hi, Eng Teck!',
                            style: 
                              TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            )
                          ],
                        ),
      
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.tag_faces_sharp, 
                            color: Colors.white),
                        ),
      
                      ],
                    ),
                    SizedBox(height: 10,),
                    //Recent Order
                    Container(
                      height: MediaQuery.of(context).size.height*0.25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(5),
                      child: Visibility(
                        visible: isRecentOrder,
                        replacement: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text('No Recent Order',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              ),
                              SizedBox(height: 5,),
                              Text('You have not made any recent order. Please make an order to see the details here.'),
                              SizedBox(height: 5,),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Text('Make an Order',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                ),
                              )
                            ],
                          ),
                        ),
                        child: DashboardRecentOrder(),
                      )
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Flexible(
              flex: 6,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                height:MediaQuery.of(context).size.height*0.9,
                color: Colors.grey[200],
                child: Column(
                  children: [
                    Center(
                      child: Icon(
                        Icons.horizontal_rule_rounded,
                        size: 50,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.9,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          const Text('Energy Purchase from',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Grid'),
                              Text('p2p market')
                            ],
                          ),
                          
                          LinearProgressIndicator(
                            value: 0.5,
                            minHeight: 10,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
      
                    Container(
                      // height: MediaQuery.of(context).size.height*0.4,
                      width: MediaQuery.of(context).size.width*0.9,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DashboardForecast(),
                    )
                    
                  ]
                ),
                ),
            )
          ],
        ),
      ),
    );
  }
}