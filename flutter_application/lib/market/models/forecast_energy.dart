class ForecastEnergy {
  final double genData;
  final double useData;

  ForecastEnergy({required this.genData, 
        required this.useData});

  factory ForecastEnergy.fromJson(Map<String, dynamic> json) {
    return ForecastEnergy(
      genData: json['genData'],
      useData: json['useData'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['genData'] = genData;
    data['useData'] = useData;
    return data;
  }
}