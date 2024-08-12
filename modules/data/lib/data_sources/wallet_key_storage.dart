import 'package:data/data_sources/secure_storage/secure_storage_service.dart';
import 'package:data/entities/data_wallet_constants.dart';
import 'package:data/entities/key_entity.dart';


class WalletKeyStorage {
  final SecureStorageService _secureStorage;

  const WalletKeyStorage(this._secureStorage);

  Future<bool> savePrivateKey({
    required String privateKey,
    required String address,
  }) async {
    final key = _getKeyStorePrivateKey(address);
    final keyEntity = KeyEntity(key: key, value: privateKey);

    return _secureStorage.saveKey(keyEntity);
  }

  Future<bool> saveMnemonic({
    required String mnemonic,
    required String address,
  }) async {
    final key = _getKeyStoreMnemonic(address);
    final keyEntity = KeyEntity(key: key, value: mnemonic);

    return _secureStorage.saveKey(keyEntity);
  }

  Future<String?> getPrivateKey(String address) async {
    final key = _getKeyStorePrivateKey(address);

    final keyEntity = await _secureStorage.getKey(key);
    return '0x${keyEntity?.value}';
  }

  Future<String?> getMnemonic(String address) async {
    final key = _getKeyStoreMnemonic(address);

    final keyEntity = await _secureStorage.getKey(key);
    return '${keyEntity?.value}';
  }

  Future<bool> deleteWalletSecureData(String address) async {
    final isMnemonicDelete = await _deleteMnemonic(address);
    final isPrivateKeyDelete = await _deletePrivateKey(address);

    return isMnemonicDelete && isPrivateKeyDelete;
  }

  Future<bool> _deletePrivateKey(String address) async {
    final key = _getKeyStorePrivateKey(address);
    final isDelete = await _secureStorage.deleteKey(key);

    return isDelete;
  }

  Future<bool> _deleteMnemonic(String address) async {
    final key = _getKeyStoreMnemonic(address);
    final isDelete = await _secureStorage.deleteKey(key);

    return isDelete;
  }

  String _getKeyStorePrivateKey(String address) {
    final prefix = const DataWalletConstants().privateKeyPrefix;

    return '${prefix}_$address';
  }

  String _getKeyStoreMnemonic(String address) {
    final prefix = const DataWalletConstants().mnemonicKeyPrefix;

    return '${prefix}_$address';
  }
}