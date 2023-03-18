import 'package:flutter/material.dart';
import 'package:flutter_application/blockchain/models/transactions.dart';
import 'package:get/get.dart';
import '../models/sample_data.dart';

class BlockChainController extends GetxController {

  List<Transaction> transactions = allTransactions.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Widget buildDataTable() {
    List columns = [
      'Date',
      'Total Transaction',
      'Total Traded Amount',
      'Details',
    ];

    return DataTable(
      columnSpacing: 20,
      columns: getColumns(columns), 
      rows: getRows(transactions));
  }

  List<DataColumn> getColumns(List columns) {
    return List<DataColumn>.generate(
      columns.length,
      (index) => DataColumn(
        label: Expanded(
          child: Text(columns[index], 
          softWrap: false, 
          maxLines: 3,
          overflow: TextOverflow.ellipsis)),
      ),
    );
  }

  List<DataRow> getRows(List<Transaction> transactions) => transactions.map((Transaction transaction) {
    return DataRow(cells: getCells([
      transaction.date,
      transaction.totalTransaction,
      transaction.totalTradedAmount,
      transaction.columnNumbers,
    ]));
  }).toList();

  List<DataCell> getCells(List cells) {
    return List<DataCell>.generate(
      cells.length,
      (index) => DataCell(Text(cells[index])),
    );
  } 

  //   Future handleEnergyForecast() async {
  //   // var jsonBody = jsonEncode(energyRequest.toJson());
  //   // final response = await http.post(Uri.http(ApiConstants.baseUrl, 
  //   //ApiConstants.handleEnergyRequestUrl), body: jsonBody, headers: headers);
  //   String userId = AuthenticationRepository.instance.firebaseUser.value!.uid;
  //   String uri = Uri.http(ApiConstants.baseUrl, 'energyForecast').toString();
  //   final response = await http.get(Uri.parse('$uri?id=$userId'),
  //       headers: <String, String>{
  //         'Authorization': 'Bearer $userId}'
  //       }
  //   );
  //   if (response.statusCode == 202){
  //     // await Future.delayed(Duration(seconds: 1));
  //     print('Successfully initialized');
  //     final model = ForecastEnergy.fromJson(jsonDecode(response.body));
  //     _forecastGenData.value = model.genData;
  //     _forecastUseData.value = model.useData;
  //     update();
  //     return model;
  //   }
  //   else {
  //     throw Exception('Failed to load data: ${response.statusCode}');
  //   }
  // }

}