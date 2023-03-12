import 'package:flutter_application/market/models/energy_request.dart';

class Market{
  final List marketdepth;

  Market({required this.marketdepth});

  factory Market.fromJson(List<dynamic> json) {
    List items = json.map((item) => EnergyRequest.fromJson(item)).toList();
    return Market(
      marketdepth: items,
    );
  }


}