import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../controllers/evcharge_controller.dart';

class EvChargePage extends StatelessWidget {
  EvChargePage({super.key});

  EVChargeController controller = Get.put(EVChargeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('EV Charge')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Scan the QR Code to start charging',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Image.asset('assets/images/qr_code.png'),
              ),
              Text(
                controller.randomNumber.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),

              Spacer(),

              CupertinoButton(
                color: Colors.blue,
                child: Text('Open QR Code Scanner'),
                onPressed: (){}
              )
            ],
          ),
        ),
      ),
    );
  }
}