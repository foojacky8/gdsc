import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MarketBuyView extends StatefulWidget {
  MarketBuyView({super.key});

  @override
  State<MarketBuyView> createState() => _MarketBuyViewState();
}

class _MarketBuyViewState extends State<MarketBuyView> {
  @override
  Widget build(BuildContext context) {

    double _currentSliderValue = 30;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Table(
                border: TableBorder.all(width: 1.0, color: Colors.black),
                children: [
                  TableRow(
                    children: [
                      Text('Energy (kWh)'),
                      Text('Price (RM)'),
                    ]
                  ),
                  TableRow(
                    children: [
                      Text('10.0)'),
                      Text('10.0'),
                    ]
                  ),
                  TableRow(
                    children: [
                      Text('10.0)'),
                      Text('10.0'),
                    ]
                  ),
                ]
                ),
            ),
            Divider(),
            Container(
              child: Column(children: [
                Text('Select Amount of Energy'),
                Slider(
                  max: 100,
                  min: 0,
                  divisions: 100,
                  value: _currentSliderValue, 
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value){
                    setState(() {
                      _currentSliderValue = value;
                    });
                  } 
                ),
                Text(
                  'Amount of Energy Selected: $_currentSliderValue kWh',
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ],)
            ),

            Container(
              child: Column(children: [
                Text('Select Bidding Price'),
                CupertinoSlider(
                  min: 0,
                  max: 100,
                  value: _currentSliderValue, 
                  onChanged: (double value){
                    setState(() {
                      _currentSliderValue = value;
                    });
                  } 
                ),
                Text(
                  'Bidding Price Selected: RM $_currentSliderValue',
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ],)
            )

          ],
        )
      ),
    );
  }
}