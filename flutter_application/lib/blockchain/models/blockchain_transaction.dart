import 'package:flutter/material.dart';
import 'market.dart';

class BlockChainTransaction {
  final int index;
  final String timestamp;
  final String hash;
  final String? previousHash;
  final Market data;
  final String? miner;
  final int? noOfTransaction;
  final double? tradedEnergy;

  BlockChainTransaction(
    this.index, 
    this.hash, 
    this.previousHash, 
    this.data, 
    this.miner, 
    this.noOfTransaction, 
    this.tradedEnergy, this.timestamp, {
    Key? key,
  });

  factory BlockChainTransaction.fromJson(Map<String, dynamic> json) {
    return BlockChainTransaction(
      json['index'],
      json['hash'],
      json['previousHash'],
      Market.fromJson(json['data']),
      json['miner'],
      json['noOfTransaction'],
      json['tradedEnergy'].toDouble(),
      json['timestamp'].toString(),
    );
  }
}