import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DashboardPage extends StatelessWidget {
  bool isRecentOrder = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF198f4c),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(25, 50, 25, 0),
            child: Column(
              children: [
                //greeting row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hi, Eng Teck',
                        style: 
                          TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text('Your Current Balance: 0.00 kWh')
                      ],
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.notifications, 
                        color: Colors.white),
                    ),

                  ],
                ),
                SizedBox(height: 10,),
                //Recent Order
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Recent Order', 
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                            Text('See All',
                            style: TextStyle(
                              color: Colors.blue,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 5,),
                        Container(
                          child: Table(
                            children: [
                              TableRow(
                                children: [
                                  Text(''),
                                  Text('Order ID'),
                                  Text('Energy (kWh)'),
                                  Text('Price (RM)'),
                                  Text('Action'),
                                ]
                              ),
                              TableRow(
                                children: [
                                  Text('BUY'),
                                  Text('123'),
                                  Text('10.0)'),
                                  Text('10.0'),
                                  Icon(Icons.delete, color: Colors.blue,)
                                ]
                              ),
                              TableRow(
                                children: [
                                  Text('SELL'),
                                  Text('124'),
                                  Text('20.0'),
                                  Text('10.0'),
                                  Icon(Icons.delete, color: Colors.blue,)
                                ]
                              ),
                              TableRow(
                                children: [
                                  Text('BUY'),
                                  Text('125'),
                                  Text('20.0'),
                                  Text('20.0'),
                                  Icon(Icons.delete, color: Colors.blue,)
                                ]
                              ),
                            ]
                            ),
                        )
                      ],
                    ),
                  )
                )
              ],
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
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
                        Text('Energy Purchase from',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                    height: MediaQuery.of(context).size.height*0.45,
                    width: MediaQuery.of(context).size.width*0.9,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Energy Forecast',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                        Text('for next 30 mintues'),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                CircularPercentIndicator(
                                  animation: true,
                                  circularStrokeCap: CircularStrokeCap.round, 
                                  radius: MediaQuery.of(context).size.width / 8,
                                  lineWidth: 8,
                                  percent: 0.8,
                                  center: Text(
                                    '0.00 kWh',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  progressColor: Colors.green,
                                  ),
                                  Text('Produced')
                              ],
                            ),
                            Column(
                              children: [
                                CircularPercentIndicator(
                                  animation: true,
                                  lineWidth: 8,
                                  percent: 0.5,
                                  circularStrokeCap: CircularStrokeCap.round, 
                                  radius: MediaQuery.of(context).size.width / 8,
                                  center: Text(
                                    '0.00 kWh',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  progressColor: Colors.blue,
                                ),
                                Text('Consumed')
                              ],
                            ),

                          ],
                        )
                      ],
                    ),
                  )
                  
                ]
              ),
              ),
          )
        ],
      ),
    );
  }
}