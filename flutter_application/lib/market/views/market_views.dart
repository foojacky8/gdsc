import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application/market/widgets/market_buy.dart';
import 'package:flutter_application/market/widgets/market_sell.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Market')),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Buy',
              ),
              Tab(
                text: 'Sell',
              ),
            ],
            indicatorColor: Colors.white,
          )
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            MarketBuyView(),
            MarketSellView()
          ]
        ),
      ),
    );
  }
}