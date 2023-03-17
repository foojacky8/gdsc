import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../market/controllers/market_data_controller.dart';

class DashboardForecast extends GetView<MarketDataController> {
  const DashboardForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  percent: 0.5, //controller.forecastGenData.value,
                  center: 
                  Obx((){
                    if (controller.forecastGenData.value == 0.0) {
                      return CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green
                        ),
                      );
                    }
                    return Text(
                      controller.forecastGenData.value.toStringAsFixed(2) + ' kWh',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
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
                  percent: 0.5, //controller.forecastUseData.value,
                  circularStrokeCap: CircularStrokeCap.round, 
                  radius: MediaQuery.of(context).size.width / 8,
                  center: 
                  Obx((){
                    if (controller.forecastUseData.value == 0.0) {
                      return CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue
                        ),
                      );
                    }
                    return Text(
                      controller.forecastUseData.value.toStringAsFixed(2) + ' kWh',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                  progressColor: Colors.blue,
                ),
                Text('Consumed')
              ],
            ),

          ],
        )
      ],
    );
  }
}