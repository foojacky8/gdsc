class User {
  final String username;
  final String email;
  final String? smartMeterNo;
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
}
