import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MarketTableData extends StatelessWidget {
  const MarketTableData({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            'Market Data',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Table(
            border: TableBorder(
              horizontalInside: BorderSide(
                color: Colors.black,
                width: 1,
                style: BorderStyle.solid,
              ),
              verticalInside: BorderSide(
                color: Colors.black,
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
            
            children: [
              TableRow(
                children: [
                  Center(child: Text('Energy (kWh)')),
                  Center(child: Text('Price (RM)')),
                ]
              ),
              TableRow(
                children: [
                  Center(child: Text('10.0)')),
                  Center(child: Text('10.0')),
                ]
              ),
              TableRow(
                children: [
                  Center(child: Text('10.0)')),
                  Center(child: Text('10.0')),
                ]
              ),
            ]
            ),
        ],
      ),
    );
  }
}