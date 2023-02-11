import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RecentOrder extends StatelessWidget {
  const RecentOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Recent Order')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Table(
        children: [
          TableRow(
            children: [
              Text(''),
              Text('Order ID'),
              Text('Energy (kWh)'),
              Text('Price (RM)'),
              Text('Action'),
            ]
          ),
          TableRow(
            children: [
              Text('BUY'),
              Text('123'),
              Text('10.0)'),
              Text('10.0'),
              Icon(Icons.delete, color: Colors.blue,)
            ]
          ),
          TableRow(
            children: [
              Text('SELL'),
              Text('124'),
              Text('20.0'),
              Text('10.0'),
              Icon(Icons.delete, color: Colors.blue,)
            ]
          ),
          TableRow(
            children: [
              Text('BUY'),
              Text('125'),
              Text('20.0'),
              Text('20.0'),
              Icon(Icons.delete, color: Colors.blue,)
            ]
          ),
        ]
        ),
      ),
    );
  }
}