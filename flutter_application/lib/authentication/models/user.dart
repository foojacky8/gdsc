import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  /// Email address of the user
  final String username;
  /// Email address of the user
  final String email;
  /// Smart meter number of the user
  final String? smartMeterNo;
  /// Firebase authentication id of the user
  final String? id;

  MyUser({
    this.smartMeterNo,
    this.id,
    required this.username,
    required this.email,
  });

  toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['smartMeterNo'] = smartMeterNo;
    data['id'] = id;
    return data;
  }

  factory MyUser.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return MyUser(
      id: snapshot.id,
      username: data?['username'],
      email: data?['email'],
      smartMeterNo: data?['smartMeterNo'],
    );
  }

  factory MyUser.fromJson(Map<String, dynamic> json) {
    return MyUser(
      username: json['username'],
      email: json['email'],
      smartMeterNo: json['smartMeterNo'],
      id: json['id'],
    );
  }
}
