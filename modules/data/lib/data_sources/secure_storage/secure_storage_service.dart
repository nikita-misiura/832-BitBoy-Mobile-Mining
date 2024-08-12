

import '../../entities/key_entity.dart';

abstract class SecureStorageService {
  /// Saves the [keyEntity] in the KeyStore.
  ///
  /// Returns [true] if the key was successfully saved.
  Future<bool> saveKey(KeyEntity keyEntity);

  /// Replaces [oldKey] with [newKey].
  ///
  /// Returns [true] if the key was successfully replaced.
  Future<bool> replaceKey(String oldKey, String newKey);

  /// Allows you to get KeyEntity by key.
  ///
  /// Returns [null] if the [key] doesn't exist.
  Future<KeyEntity?> getKey(String key);

  /// Allows you to get a list of all saved keys in the KeyStore.
  Future<List<KeyEntity>> getAllKeys();

  /// Deletes the [key] from the KeyStore.
  ///
  /// Returns [true] if the key was successfully deleted.
  Future<bool> deleteKey(String key);

  /// Deletes all saved keys from the KeyStore.
  Future<bool> deleteAllKeys();
}
