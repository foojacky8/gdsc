import 'package:flutter/material.dart';
import 'package:flutter_application/market/controllers/market_controller.dart';
import 'package:flutter_application/market/models/energy_request.dart';
import 'package:flutter_application/market/widgets/market_table.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../controllers/market_data_controller.dart';
import '../models/energy_request.dart';

import '../controllers/market_data_controller.dart';
import '../models/energy_request.dart';

class MarketSellView extends GetView<MarketController> {
  MarketSellView({super.key});
  final RxDouble _currentEnergyValue = 0.0.obs;
  final RxDouble _currentBidPriceValue = 0.3.obs;

  @override
  Widget build(BuildContext context) {
    MarketDataController marketdatacontroller = Get.put(MarketDataController());

    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MarketTableData(
              action: 'Sell',
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
                child: Column(
              children: [
                const Text(
                  'Select Amount of Energy',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Obx((){
                  double maxNum = double.parse((marketdatacontroller.forecastGenData.value).toStringAsFixed(2));
                  return Slider(
                    max: maxNum,
                    min: 0,
                    divisions: 10,
                    value: _currentEnergyValue.value,
                    label: _currentEnergyValue.round().toString(),
                    onChanged: (double value) {
                      _currentEnergyValue.value = double.parse((value).toStringAsFixed(2));
                    });
                }),
                Text(
                  'Amount of Energy Selected: $_currentEnergyValue kWh',
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            )),
            const SizedBox(
              height: 30,
            ),
            Center(
                child: Column(
              children: [
                const Text(
                  'Select Bidding Price',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Slider(
                    max: 0.5,
                    min: 0.3,
                    divisions: 20,
                    value: _currentBidPriceValue.value,
                    // label: _currentBidPriceValue.round().toString(),
                    onChanged: (double value) {
                      _currentBidPriceValue.value = value;
                    }),
                Text(
                  'Bidding Price Selected: RM $_currentBidPriceValue',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.all(25),
                  child: OutlinedButton(
                    onPressed: () {
                      EnergyRequest energyRequest =
                          controller.createEnergyRequest(
                              _currentEnergyValue.value,
                              _currentBidPriceValue.value,
                              'Sell');
                      controller.createBid(energyRequest);
                      Fluttertoast.showToast(
                          msg: "Ask Submmited",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 14.0);
                      // Get.back();
                      // EnergyRequest energyRequest = EnergyRequest(
                      //     energyAmount: _currentEnergyValue.value.toInt(),
                      //     biddingPrice: _currentBidPriceValue.value,
                      //     buyOrSell: 'Sell', 
                      //     bidID: '',
                      //     userID: ''
                      //     );
                      // controller.postData(energyRequest);
                    },
                    child: const Text('Submit Ask',
                        style: TextStyle(color: Colors.red)),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      controller.runAuction();
                    },
                    child: const Text('Auction'))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
