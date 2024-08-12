import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../entities/key_entity.dart';
import 'secure_storage_service.dart';


class SecureStorageServiceImpl implements SecureStorageService {
  final FlutterSecureStorage _secureStorage;

  const SecureStorageServiceImpl(this._secureStorage);

  @override
  Future<bool> saveKey(KeyEntity keyEntity) async {
    try {
      final key = keyEntity.key;
      final value = keyEntity.value;

      await _secureStorage.write(key: key, value: value);
    } on PlatformException {
      return false;
    }

    return true;
  }

  @override
  Future<bool> replaceKey(String oldKey, String newKey) async {
    final oldKeyEntity = await getKey(oldKey);

    if (oldKeyEntity == null) return false;

    final newKeyEntity = KeyEntity(key: newKey, value: oldKeyEntity.value);
    final isNewKeySaved = await saveKey(newKeyEntity);

    if (!isNewKeySaved) return false;

    await deleteKey(oldKey);

    return true;
  }

  @override
  Future<KeyEntity?> getKey(String key) async {
    final value = await _secureStorage.read(key: key);

    if (value == null) return null;

    return KeyEntity(key: key, value: value);
  }

  @override
  Future<List<KeyEntity>> getAllKeys() async {
    final keysMap = await _secureStorage.readAll();
    final keysEntries = keysMap.entries;

    return keysEntries
        .map((e) => KeyEntity(key: e.key, value: e.value))
        .toList();
  }

  @override
  Future<bool> deleteKey(String key) async {
    final isKeyExists = await _secureStorage.containsKey(key: key);

    if (!isKeyExists) return false;

    try {
      await _secureStorage.delete(key: key);
    } on PlatformException {
      return false;
    }

    return true;
  }

  @override
  Future<bool> deleteAllKeys() async {
    try {
      await _secureStorage.deleteAll();
    } on PlatformException {
      return false;
    }

    return true;
  }
}
