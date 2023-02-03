import 'package:data_table_2/data_table_2.dart';
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
      'Column NUMBERS',
    ];

    return DataTable2(
      columns: getColumns(columns), 
      rows: getRows(transactions));
  }

  List<DataColumn2> getColumns(List columns) {
    return List<DataColumn2>.generate(
      columns.length,
      (index) => DataColumn2(
        label: Text(columns[index]),
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

}