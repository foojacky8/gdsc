import 'dart:math';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class EVChargeController extends GetxController{

  RxString randomNumber = ''.obs;

  @override
  void onInit() {
    super.onInit();
    generateNumber();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void generateNumber (){
    Random random = new Random();
    for (var i = 0; i < 16; i++) {
      if (i%4 == 0){
        randomNumber.value += " ";
      }
      randomNumber.value += random.nextInt(9).toString();
    }
    print(randomNumber.value);
    randomNumber.refresh();    
  }
}