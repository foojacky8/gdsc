import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/evcharge/controllers/evcharge_controller.dart';
import 'package:get/get.dart';

class ChargingPanel extends GetView<EVChargeController> {
  final RxDouble _chargePercentage = 0.0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Charging panel')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  const Text("Select a charging station: "),
                  Obx(
                    () => DropdownButton(
                      value: controller.selectedChargingStation.value,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        controller.selectedChargingStation.value = value!;
                      },
                      items: controller.chargingStationList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Row(
                children: const [
                  Text("Charging price: RM10.00/kWh"),
                ],
              ),
              Obx(() {
                double maxNum = 100;
                return Slider(
                    max: maxNum,
                    min: 0,
                    divisions: 20,
                    value: _chargePercentage.value,
                    label: _chargePercentage.round().toString(),
                    onChanged: (double value) {
                      _chargePercentage.value =
                          double.parse((value).toStringAsFixed(2));
                    });
              }),
              Obx(() => Text(
                    'Desired battery level: ${_chargePercentage.value.round()} %',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoButton(
                    color: Colors.blue,
                    child: const Text("Confirm and start charge"),
                    onPressed: () {}),
              )
            ],
          ),
        ),
      ),
    );
  }
}
