class EnergyRequest{
  String? bidID;  // Cannot be final because we want to set this as document ID from Firestore later
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
      energyAmount: json['energyAmount'].toDouble(),
      biddingPrice: json['biddingPrice'].toDouble(),
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