import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  //create storage
  static const storage =  FlutterSecureStorage();

  static const String _keyEmail = 'email';
  static const String _keyPassword = 'password';
  static const String _keyJwt = 'jwt';

  static Future<String?> getEmail() async {
    return await storage.read(key: _keyEmail);
  }

  static Future setEmail(String email) async {
    await storage.write(key: _keyEmail, value: email);
  }

  static Future setPassword(String password) async {
    await storage.write(key: _keyPassword, value: password);
  }

  static Future<String?> getPassword() async {
    return await storage.read(key: _keyPassword);
  }

  static Future setJwt(String jwt) async {
    await storage.write(key: _keyJwt, value: jwt);
  }

  static Future<String?> getJwt() async {
    return await storage.read(key: _keyJwt);
  }
}
