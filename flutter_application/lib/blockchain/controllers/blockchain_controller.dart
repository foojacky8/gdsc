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

}