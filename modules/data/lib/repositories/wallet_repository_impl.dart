import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:data/entities/domain_wallet_constants.dart';
import 'package:domain/repositories/wallet_repository.dart';
import 'package:flutter_trust_wallet_core/core/hd_wallet.dart';
import 'package:infrastructure/logger/logger_barrel.dart';
import 'package:bs58check/bs58check.dart' as bs58check;

import '../data_sources/wallet_data_source.dart';
import '../entities/wallet_info.dart';


class WalletRepositoryImpl extends WalletRepository {
  final WalletLocalDataSource _walletDataSource;
  final coinType = DomainWalletConstants.TWDefaultChain;

  WalletRepositoryImpl(this._walletDataSource);

  @override
  Future<String> createWallet() async {
    final hdWallet = HDWallet();
    final address = await _createWallet(hdWallet);
    hdWallet.delete();

    return address;
  }

  Future<String> _createWallet(HDWallet hdWallet) async {
    final address = hdWallet.getAddressForCoin(coinType);
    await _walletDataSource.saveHDWallet(hdWallet: hdWallet);

    return address;
  }

  @override
  Future<WalletInfo?> exportWalletInfo() async {
    return _walletDataSource.getWalletInfo();
  }

  @override
  Future<String?> getWalletAddress() async {
    final address = await _walletDataSource.getAddressFromSharedPreferences();
    if (address != null) {
      logger.i('address: $address');
      return address;
    } else {
      logger.e('address not found in shared preferences');
      throw Exception('address not found in shared preferences');
    }
  }

  @override
  Future<String?> importWalletByMnemonic(String mnemonic) async {
    final hdWallet = HDWallet.createWithMnemonic(mnemonic);
    final address = await _createWallet(hdWallet);
    hdWallet.delete();

    return address;
  }

  @override
  Future<String?> importWalletByPrivateKey(String privateKey) async {
    final decodePrivateKey = _mapPrivateKeyStringToData(privateKey);

    if (decodePrivateKey != null) {
      final hdWallet = HDWallet.createWithData(decodePrivateKey);
      final address = await _createWallet(hdWallet);
      hdWallet.delete();

      return address;
    } else {
      logger.e('can not decode private key');

      return null;
    }
  }

  Uint8List? _mapPrivateKeyStringToData(String privateKey) {
    try {
      final privateKeyHex = hex.decode(privateKey);

      return Uint8List.fromList(privateKeyHex);
    } catch (e) {
      return _decodeBase58(privateKey);
    }
  }

  Uint8List? _decodeBase58(String key) {
    try {
      final base58Check = bs58check.decode(key);
      final base58 = base58Check.sublist(1, base58Check.length - 1);

      return base58;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> deleteWalletData() => _walletDataSource.deleteWalletData();

  @override
  Future<bool> haveWallet() async {
    final walletInfo = await exportWalletInfo();
    if(walletInfo!=null) return true;

    return false;
  }
}
