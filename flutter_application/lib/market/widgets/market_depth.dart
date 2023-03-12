// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});



//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.8,
//       child: DataTable(
//         columnSpacing: 12,
//         horizontalMargin: 12,

//         columns: 
//         [
//           DataColumn(
//           label: Text('BidID'),
//           ),

//           DataColumn(
//           label: Text('Actions'),
//           ),

//           DataColumn(
//           label: Text('BiddingPrice'),
//           ),

//           DataColumn(
//             label: Text('Energy'),
//           ),
//         ], 
//         rows:
//         // [
//         //   DataRow(cells: [
//         //     DataCell(Text('10 kWh')),
//         //     DataCell(Text('10.0')),
//         //     DataCell(Text('2')),
//         //     DataCell(Text('10 kWh')),
//         //     DataCell(Text('20.0')),
//         //     DataCell(Text('2')),
//         //   ]
//         //   ),
//         // ], 
//         fetchDataController.market.marketdepth.map((e) => DataRow(cells: [
//           DataCell(Text(e.bidID.toString())),
//           DataCell(Text(e.BuyOrSell.toString())),
//           DataCell(Text(e.biddingPrice.toString())),
//           DataCell(Text(e.energyAmount.toString())),
//         ])).toList(),
//       ),
//     );
//   }
// }