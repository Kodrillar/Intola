import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  Future<void> write({required StoreObject storeObject}) async {
    await _storage.write(key: storeObject.key, value: storeObject.value);
  }

  Future<String?> read({required key}) async {
    final data = await _storage.read(key: key);
    return data;
  }

  Future<void> delete({required key}) async {
    await _storage.delete(key: key);
  }
}

class StoreObject {
  StoreObject({
    required this.key,
    required this.value,
  });
  final String key;
  final String value;
}
