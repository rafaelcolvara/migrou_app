import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = FlutterSecureStorage();
  Future salvarSecureData(String key, String value) async {
    var salvarData = await _storage.write(key: key, value: value);
    return salvarData;
  }

  Future<String> lerSecureData(String key) async {
    String lerData = await _storage.read(key: key);
    return lerData;
  }

  Future deleteSecureData(String key) async {
    var deleteData = await _storage.delete(key: key);
    return deleteData;
  }
}
