import 'package:flutter_application/market/models/order.dart';

class Market{
  final List marketdepth;

  Market({required this.marketdepth});

  factory Market.fromJson(List<dynamic> json) {
    List items = json.map((item) => Order.fromJson(item)).toList();
    return Market(
      marketdepth: items,
    );
  }


}