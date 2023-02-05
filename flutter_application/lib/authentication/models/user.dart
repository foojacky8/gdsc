import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  /// Email address of the user
  final String username;
  /// Email address of the user
  final String email;
  /// Smart meter number of the user
  final String? smartMeterNo;
  /// Firebase authentication id of the user
  final String? id;

  User({
    this.smartMeterNo,
    this.id,
    required this.username,
    required this.email,
  });

  toJson() {
    return {
      'username': username,
      'email': email,
      'smartMeterNo': smartMeterNo,
      'id': id,
    };
  }

  factory User.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return User(
      id: snapshot.id,
      username: data?['username'],
      email: data?['email'],
      smartMeterNo: data?['smartMeterNo'],
    );
  }
}
