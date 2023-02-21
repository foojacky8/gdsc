class Order{
  final String bidID;
  final String userID;
  final int energyAmount;
  final double biddingPrice;
  final String BuyOrSell;

  Order({required this.bidID, 
        required this.userID, 
        required this.energyAmount, 
        required this.biddingPrice, 
        required this.BuyOrSell});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      bidID: json['bidID'],
      userID: json['userID'],
      energyAmount: json['energyAmount'],
      biddingPrice: json['biddingPrice'],
      BuyOrSell: json['BuyOrSell'],
    );
  }
}