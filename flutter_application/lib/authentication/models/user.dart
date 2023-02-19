import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  /// Email address of the user
  final String username;
  /// Email address of the user
  final String email;
  /// Smart meter number of the user
  final String? smartMeterNo;
  /// Firebase authentication id of the user
  String? id;
  /// GenData of the user
  List<double>? genData;
  /// UseData of the user
  List<double>? useData;

  MyUser({
    this.smartMeterNo,
    this.id,
    this.genData,
    this.useData,
    required this.username,
    required this.email,
  });

  toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['smartMeterNo'] = smartMeterNo;
    data['id'] = id;
    data['genData'] = genData;
    data['useData'] = useData;
    return data;
  }

  factory MyUser.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return MyUser(
      id: snapshot.id,
      username: data?['username'],
      email: data?['email'],
      smartMeterNo: data?['smartMeterNo'],
      genData: data?['genData'],
      useData: data?['useData'],
    );
  }

  factory MyUser.fromJson(Map<String, dynamic> json) {
    return MyUser(
      username: json['username'],
      email: json['email'],
      smartMeterNo: json['smartMeterNo'],
      id: json['id'],
      genData: json['genData'],
      useData: json['useData'],
    );
  }
}
