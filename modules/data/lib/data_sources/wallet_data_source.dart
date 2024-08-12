import 'package:convert/convert.dart';
import 'package:data/data_sources/shared_preferences/shared_preferences_service.dart';
import 'package:data/data_sources/wallet_key_storage.dart';
import 'package:flutter_trust_wallet_core/flutter_trust_wallet_core.dart';
import 'package:infrastructure/logger/logger_barrel.dart';

import '../entities/entity_barrel.dart';


class WalletLocalDataSource {
  final SharedPreferencesService _sharedPreferences;
  final WalletKeyStorage _walletKeyStorage;

  const WalletLocalDataSource(this._sharedPreferences, this._walletKeyStorage);

  Future<void> saveHDWallet({required HDWallet hdWallet}) async {
    final address = _getAddressFromHdWallet(hdWallet);
    final privateKey = await _getEncodePrivateKeyFromWallet(hdWallet);
    final mnemonic = hdWallet.mnemonic();

    await _saveAddressToSharedPreferences(address);
    await _walletKeyStorage.saveMnemonic(mnemonic: mnemonic, address: address);
    await _walletKeyStorage.savePrivateKey(
      privateKey: privateKey,
      address: address,
    );
  }

  Future<String> _getEncodePrivateKeyFromWallet(HDWallet hdWallet) async {
    const coin = DomainWalletConstants.TWDefaultChain;
    final privateKey = hdWallet.getKeyForCoin(coin).data();
    final encodePrivateKey = hex.encode(privateKey);

    return encodePrivateKey;
  }

  Future<void> _saveAddressToSharedPreferences(String address) async {
    final addressKey = const DataWalletConstants().addressKey;

    await _sharedPreferences.setValue(key: addressKey, value: address);
  }

  Future<String?> getAddressFromSharedPreferences() async {
    final addressKey = const DataWalletConstants().addressKey;

    return await _sharedPreferences.getValue<String>(key: addressKey);
  }

  String _getAddressFromHdWallet(HDWallet hdWallet) {
    return hdWallet.getAddressForCoin(DomainWalletConstants.TWDefaultChain);
  }

  Future<WalletInfo> getWalletInfo() async {
    final address = await getAddressFromSharedPreferences();
    if (address != null) {
      final privateKey = await _walletKeyStorage.getPrivateKey(address);
      final mnemonic = await _walletKeyStorage.getMnemonic(address);

      if (privateKey != null && mnemonic != null) {
        final walletInfo = WalletInfo(
          privateKey: privateKey,
          mnemonic: mnemonic,
          address: address,
        );

        return walletInfo;
      } else {
        logger.e('can not found private key or mnemonic in secure storage');
        throw Exception('can not found private key or mnemonic');
      }
    } else {
      logger.e('can not found the wallet address in secure storage');
      throw Exception('can not found the wallet address');
    }
  }

  Future<bool> deleteWalletData() async {
    final address = await getAddressFromSharedPreferences();

    if(address!=null) {
      final isDelete = await _walletKeyStorage.deleteWalletSecureData(address);

      return isDelete;
    }

    return false;
  }
}
