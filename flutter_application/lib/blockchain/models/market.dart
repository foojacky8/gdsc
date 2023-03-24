import 'package:flutter_application/market/models/energy_request.dart';

import 'blockchain_energy.dart';

class Market{
  final List marketdepth;

  Market({required this.marketdepth});

  factory Market.fromJson(List<dynamic> json) {
    List items = json.map((item) => BlockChainEnergy.fromJson(item)).toList();
    return Market(
      marketdepth: items,
    );
  }


}