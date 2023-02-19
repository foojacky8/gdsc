class EnergyDataResponse {
  List<double> genData;
  List<double> useData;

  EnergyDataResponse({
    required this.genData,
    required this.useData,
  });

  factory EnergyDataResponse.fromJson(Map<String, dynamic> response) {
    List<double> genDataList = [];
    for (var element in response['genData']) {
      if (element is double) {
        genDataList.add(element);
      }
    }

    List<double> useDataList = [];
    for (var element in response['useData']) {
      if (element is double) {
        useDataList.add(element);
      }
    }

    return EnergyDataResponse(
      genData: genDataList,
      useData: useDataList,
    );
  }
}
