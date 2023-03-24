import 'package:flutter_application/blockchain/models/blockchain_transaction.dart';
import 'package:flutter_application/market/models/energy_request.dart';

class BlockChainMarket{
  final List blockchaindepth;

  BlockChainMarket({required this.blockchaindepth});

  factory BlockChainMarket.fromJson(List<dynamic> json) {
    List items = json.map((item) => BlockChainTransaction.fromJson(item)).toList();
    return BlockChainMarket(
      blockchaindepth: items,
    );
  }


}