import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/market/models/energy_request.dart';
import 'package:flutter_application/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter_application/repository/market_repository/market_repository.dart';
import 'package:get/get.dart';
import '../widgets/market_buy.dart';
import '../widgets/market_sell.dart';

class MarketController extends GetxController with GetTickerProviderStateMixin {
  List<Widget> tabViews = [];
  List<Widget> tabHeaders = [];
  late final TabController tabController;
  RxInt selectedIndex = 0.obs;
  RxBool isLoading = false.obs;

  RxInt count = 0.obs;
  RxList<EnergyRequest> data = List<EnergyRequest>.empty().obs;

  static MarketController to = Get.find();
  MarketRepository marketRepository = Get.put(MarketRepository());

  @override
  void onInit() {
    super.onInit();
    tabHeaders = [const Tab(text: 'Buy'), const Tab(text: 'Sell')];
    tabViews = [MarketBuyView(), MarketSellView()];
    tabController = TabController(
        initialIndex: selectedIndex.value,
        length: tabHeaders.length,
        vsync: this);

    getAllBids();

    FirebaseFirestore.instance
        .collection('energyRequest')
        .snapshots()
        .listen((snapshot) {
      final newEnergyRequestList =
          snapshot.docs.map((doc) => EnergyRequest.fromJson(doc.data()));
      data.assignAll(newEnergyRequestList);
    });
  }

  void updateTabController(int index) {
    selectedIndex.value = index;
    tabController.animateTo(index);
  }

  void addItem(EnergyRequest item) {
    data.add(item);
    count.value++;
  }

  void createBid(EnergyRequest energyRequest) async {
    isLoading.value = true;
    await MarketRepository.instance.addEnergyRequestToFirestore(energyRequest,
        updateObjectWithDocumentId: true);
    isLoading.value = false;
  }

  getTopBids() async {
    isLoading.value = true;
    data.clear();
    await MarketRepository.instance
        .getAllEnergyRequestFromFirestore()
        .then((value) {
      value.docs.forEach((element) {
        data.add(EnergyRequest.fromJson(element.data()));
      });
    });
    sortBids();
    isLoading.value = false;
    return data;
  }

  getAllBids() async {
    List<EnergyRequest> energyRequestList = [];
    await MarketRepository.instance
        .getAllEnergyRequestFromFirestore()
        .then((value) {
      value.docs.forEach((element) {
        energyRequestList.add(EnergyRequest.fromJson(element.data()));
      });
    });

    data.assignAll(energyRequestList);
  }

  sortBids() {
    data.sort((a, b) => a.biddingPrice.compareTo(b.biddingPrice));
  }

  createEnergyRequest(
      double energyAmount, double biddingPrice, String buyOrSell) {
    String userId = AuthenticationRepository.instance.firebaseUser.value!.uid;

    return EnergyRequest(
      bidID: null,
      userID: userId,
      energyAmount: energyAmount,
      biddingPrice: biddingPrice,
      buyOrSell: buyOrSell,
    );
  }
}
