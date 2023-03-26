import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application/blockchain/models/blockchain_energy.dart';
import 'package:flutter_application/blockchain/models/blockchain_market.dart';
import 'package:flutter_application/blockchain/models/blockchain_transaction.dart';
import 'package:flutter_application/blockchain/models/transactions.dart';
import 'package:get/get.dart';
import '../../repository/api/api_constants.dart';
import '../../repository/authentication_repository/authentication_repository.dart';
import '../models/market.dart';
import '../models/sample_data.dart';
import 'package:http/http.dart' as http;

class BlockChainController extends GetxController {

  List<Transaction> transactions = allTransactions.obs;
  RxList blockChainData = List.empty().obs;
  RxBool isLoading = false.obs;
  RxString selectedHash = ''.obs;

  RxList<BlockChainEnergy> buyDetail = List<BlockChainEnergy>.empty().obs;
  RxList<BlockChainEnergy> sellDetail = List<BlockChainEnergy>.empty().obs;
  RxList<BlockChainEnergy> recentDetail = List<BlockChainEnergy>.empty().obs;

  RxList<BlockChainEnergy> buyCurrentDetail = List<BlockChainEnergy>.empty().obs;
  RxList<BlockChainEnergy> sellCurrentDetail = List<BlockChainEnergy>.empty().obs;


  @override
  Future<void> onInit() async {
    super.onInit();
    await handleBlockChain();

    getBuyEnergyRequests();
    getSellEnergyRequests();

    // model.then((value) {
    //   blockChainData.assignAll(value);
    // });

    }

  @override
  void onClose() {
    super.onClose();
  }

  // Widget buildDataTable() {
  //   List columns = [
  //     'Date',
  //     'Total Transaction',
  //     'Total Traded Amount',
  //     'Details',
  //   ];

  //   return DataTable(
  //     columnSpacing: 20,
  //     columns: getColumns(columns), 
  //     rows: getRows(transactions));
  // }

  // List<DataColumn> getColumns(List columns) {
  //   return List<DataColumn>.generate(
  //     columns.length,
  //     (index) => DataColumn(
  //       label: Expanded(
  //         child: Text(columns[index], 
  //         softWrap: false, 
  //         maxLines: 3,
  //         overflow: TextOverflow.ellipsis)),
  //     ),
  //   );
  // }

  // List<DataRow> getRows(List<Transaction> transactions) => transactions.map((Transaction transaction) {
  //   return DataRow(cells: getCells([
  //     transaction.date,
  //     transaction.totalTransaction,
  //     transaction.totalTradedAmount,
  //     transaction.columnNumbers,
  //   ]));
  // }).toList();

  List<DataCell> getCells(List cells) {
    return List<DataCell>.generate(
      cells.length,
      (index) => DataCell(Text(cells[index])),
    );
  } 

  Future handleBlockChain() async {
    isLoading.value = true;
    final response = await http.get(Uri.http(ApiConstants.baseUrl, 'getBlockchain'));

    if (response.statusCode == 202){
      // await Future.delayed(Duration(seconds: 1));
      print('Successfully initialized');
      final model = BlockChainMarket.fromJson(jsonDecode(response.body));
      model.blockchaindepth.removeAt(0);
      blockChainData.value = model.blockchaindepth;
      update();
      isLoading.value = false;
      return model;
    }
    else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  getBuyEnergyRequests() {
    List<BlockChainEnergy> buyEnergyRequestList = [];
    for (var element in blockChainData.value) {
      List market = element.data.marketdepth;
      for(var item in market) {
        if (item.buyOrSell == 'Buy') {
          buyEnergyRequestList.add(item);
        }
      }
      
    }

    // sort the list by highest bidding price first
    sortBids(buyEnergyRequestList, 'Buy');
    buyDetail.assignAll(buyEnergyRequestList);

  }

  sortBids(List<BlockChainEnergy> listOfEnergyRequest, String action) {
    if (action == 'Buy') {
      listOfEnergyRequest
          .sort((a, b) => b.price.compareTo(a.price));
    } else if (action == 'Sell') {
      listOfEnergyRequest
          .sort((a, b) => a.price.compareTo(b.price));
    }
  }

  getSellEnergyRequests() {
    List<BlockChainEnergy> sellEnergyRequestList = [];

    for (var element in blockChainData.value) {
      List market = element.data.marketdepth;
      for(var item in market) {
        if (item.buyOrSell == 'Sell') {
          sellEnergyRequestList.add(item);
        }
      }
      
    }

    // sort the list by highest bidding price first
    sortBids(sellEnergyRequestList, 'Sell');
    sellDetail.assignAll(sellEnergyRequestList);

  }

  getCurrentMarket(String hash){
    List<BlockChainEnergy> currentMarket = [];
    List<BlockChainEnergy> buyList = [];
    List<BlockChainEnergy> sellList = [];

    for (var element in blockChainData.value) {
      if (element.hash == hash) {
        List market = element.data.marketdepth;
        for(var item in market) {
          if (item.buyOrSell == 'Buy') {
            buyList.add(item);
          }
          if (item.buyOrSell == 'Sell') {
            sellList.add(item);
          }
        }
      }
    }
    recentDetail.assignAll(currentMarket);
    buyCurrentDetail.assignAll(buyList);
    sellCurrentDetail.assignAll(sellList);

    return recentDetail;
  } 

}