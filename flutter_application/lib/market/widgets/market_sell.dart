import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application/market/widgets/market_table.dart';

class MarketSellView extends StatefulWidget {
  MarketSellView({super.key});
  double _currentEnergyValue = 30;
  double _currentBidPriceValue = 30;

  @override
  State<MarketSellView> createState() => _MarketSellViewState();
}

class _MarketSellViewState extends State<MarketSellView> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MarketTableData(),
          SizedBox(height: 30,),
          Center(
            child: Column(
              children: [
              Text('Select Amount of Energy',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),

                ),
              Slider(
                max: 100,
                min: 0,
                divisions: 10,
                value: widget._currentEnergyValue, 
                label: widget._currentEnergyValue.round().toString(),
                onChanged: (double value){
                  setState(() {
                    widget._currentEnergyValue = value;
                  });
                } 
              ),
              Text(
                'Amount of Energy Selected: ${widget._currentEnergyValue} kWh',
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],)
          ),

          SizedBox(height: 30,),

          Center(
            child: Column(
              children: [
              Text('Select Bidding Price',
               style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),),
              Slider(
                max: 100,
                min: 0,
                divisions: 10,
                value: widget._currentBidPriceValue, 
                label: widget._currentBidPriceValue.round().toString(),
                onChanged: (double value){
                  setState(() {
                    widget._currentBidPriceValue = value;
                  });
                } 
              ),
              Text(
                'Bidding Price Selected: RM ${widget._currentBidPriceValue}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              

              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.all(25),
                child: OutlinedButton(
                  onPressed: (){
                    final snackBar = Positioned(
                      top: 10,
                      child: SnackBar(
                        margin: EdgeInsets.all(25),
                        content: Text('Bid Submitted'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: (){},
                        ),
                      ),
                    );
                  }, 
                  child: Text('Submit Bid'),),
              ), 
            ],)
          )

        ],
      ),
    );
  }
}