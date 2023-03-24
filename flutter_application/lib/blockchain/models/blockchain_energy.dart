class BlockChainEnergy{
  String? bidID;  // Cannot be final because we want to set this as document ID from Firestore later
  final String userID;
  final double price;
  final double toGrid;
  final double toMarket;
  final String buyOrSell;
  final double totalAmount;

  BlockChainEnergy(
        {required this.bidID, 
        required this.userID, 
        required this.price, 
        required this.toGrid, 
        required this.toMarket,
        required this.buyOrSell,
        required this.totalAmount,
        });

  factory BlockChainEnergy.fromJson(Map<String, dynamic> json) {
    return BlockChainEnergy(
      bidID: json['bidID'],
      userID: json['userID'],
      price: json['price'].toDouble(),
      toGrid: json['toGrid'].toDouble(),
      toMarket: json['toMarket'].toDouble(),
      buyOrSell: json['BuyOrSell'],
      totalAmount: json['totalAmount'].toDouble(),
    );
  }
}