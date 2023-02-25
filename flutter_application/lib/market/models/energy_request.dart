class EnergyRequest{
  final String bidID;
  final String userID;
  final double energyAmount;
  final double biddingPrice;
  final String buyOrSell;

  EnergyRequest({required this.bidID, 
        required this.userID, 
        required this.energyAmount, 
        required this.biddingPrice, 
        required this.buyOrSell});

  factory EnergyRequest.fromJson(Map<String, dynamic> json) {
    return EnergyRequest(
      bidID: json['bidID'],
      userID: json['userID'],
      energyAmount: json['energyAmount'],
      biddingPrice: json['biddingPrice'],
      buyOrSell: json['BuyOrSell'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bidID'] = bidID;
    data['userID'] = userID;
    data['energyAmount'] = energyAmount;
    data['biddingPrice'] = biddingPrice;
    data['BuyOrSell'] = buyOrSell;
    return data;
  }
}