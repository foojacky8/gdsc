import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application/market/controllers/market_fetch_data_controller.dart';
import 'package:flutter_application/market/models/energy_request.dart';
import 'package:flutter_application/market/widgets/market_table.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class MarketBuyView extends StatelessWidget {
  MarketBuyView({super.key});
  final RxDouble _currentEnergyValue = 30.0.obs;
  final RxDouble _currentBidPriceValue = 30.0.obs;

  @override
  Widget build(BuildContext context) {
    MarketFetchDataController controller = Get.put(MarketFetchDataController());

    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MarketTableData(action: 'Buy'),
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
                Slider(
                    max: 100,
                    min: 0,
                    divisions: 10,
                    value: _currentEnergyValue.value,
                    label: _currentEnergyValue.round().toString(),
                    onChanged: (double value) {
                      _currentEnergyValue.value = value;
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
                    max: 100,
                    min: 0,
                    divisions: 10,
                    value: _currentBidPriceValue.value,
                    label: _currentBidPriceValue.round().toString(),
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
                      Fluttertoast.showToast(
                          msg: "Bid Submmited",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          // backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 14.0);
                      Get.back();
                      EnergyRequest energyRequest = EnergyRequest(
                          energyAmount: _currentEnergyValue.value.toInt(),
                          biddingPrice: _currentBidPriceValue.value,
                          buyOrSell: 'Buy', 
                          bidID: '',
                          userID: ''
                          );
                      controller.postData(energyRequest);
                    },
                    child: const Text('Submit Bid'),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
